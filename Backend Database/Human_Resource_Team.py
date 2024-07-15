from datetime import date
import openpyxl
import mysql.connector
import pandas as pd
mydb= mysql.connector.connect(host="localhost",user="root",passwd="anjuli2012",database="rct")

mycursor=mydb.cursor()


def listofclaims():
    person_names = []
    person_ids = []
    dates = []
    vendors=[]
    claimids=[]
    statuses=[]
    mycursor.execute("SELECT PersonID,generationdate,VendorID,ClaimID,ClaimStatus FROM Claim where manager= 'HR' ")
    claim_data = mycursor.fetchall()
    for row in claim_data:
        person_id,date,vendor,claimid,cstatus = row
        person_ids.append(person_id)
        dates.append(date)
        vendors.append(vendor)
        claimids.append(claimid)
        statuses.append(cstatus)

        # Fetch PersonName from EmployeeMaster table based on PersonID
        mycursor.execute("SELECT PersonName FROM EmployeeMaster WHERE PersonID = %s", (person_id,))
        person_name = mycursor.fetchone()
        if person_name:
            person_names.append(person_name[0])
        else:
            person_names.append("Unknown")  # If PersonName is not found, add "Unknown"
    return person_names,person_ids,dates,vendors,claimids,statuses

person_names,person_ids,dates,vendors,claimids,statuses=listofclaims()

#print(statuses)


def getstatus(statuses):
    status_list = ["Pending" if status == 0 else "Approved" if status == 1 else "Rejected" if status==-1 else "closed" for status in statuses]
    return status_list


def getstatustable(claimid):
    cursor = mydb.cursor()

    # Step 1: Retrieve the relevant data from the Status table for the given claimid
    query = "SELECT Status, DateOfChange, ChangedBy_emp_id, TimesRejected, Manager FROM Status WHERE ClaimID = %s"
    cursor.execute(query, (claimid,))
    result = cursor.fetchall()

    # Step 2: Initialize lists to store the data
    status_list = []
    chdate_list = []
    chby_list = []
    rejected_list = []
    manager_list = []

    # Step 3: Append the data to the respective lists
    for row in result:
        status_list.append(row[0])
        chdate_list.append(row[1])
        chby_list.append(row[2])
        rejected_list.append(row[3])
        manager_list.append(row[4])

    return status_list, chdate_list, chby_list, rejected_list, manager_list

#status, date_of_change, changed_by, times_rejected, manager = getstatustable(1)

# print("Status List:", status)
# print("DateOfChange List:", date_of_change)
# print("ChangedBy_emp_id List:", changed_by)
# print("TimesRejected List:", times_rejected)
# print("Manager List:", manager)    


def getremarks(claimid):
    cursor = mydb.cursor()

    # Step 1: Retrieve the relevant data from the Recovery table for the given claimid
    query = "SELECT DisputeID, Remarks FROM Recovery WHERE ClaimID = %s"
    cursor.execute(query, (claimid,))
    result = cursor.fetchall()

    # Step 2: Initialize lists to store the data
    dispid_list = []
    remark_list = []

    # Step 3: Append the data to the respective lists
    for row in result:
        dispid_list.append(row[0])
        remark_list.append(row[1])

    return dispid_list, remark_list


#dispute_id, remarks = getremarks(1)

#print("DisputeID List:", dispute_id)
#print("Remarks List:", remarks)

#needed for approve and reject
def get_latest_status_info(claimid):
    cursor = mydb.cursor()
    status_query = "SELECT DateOfChange, TimesRejected FROM Status WHERE ClaimID = %s ORDER BY DateOfChange DESC LIMIT 1"
    cursor.execute(status_query, (claimid,))
    result = cursor.fetchone()
    cursor.close()
    return result

def approve(claimid, managerempid):
    cursor = mydb.cursor()

    # Step 1: Update the manager field for the given ClaimID in the Claim table
    update_query = "UPDATE Claim SET manager = %s WHERE ClaimID = %s"
    manager = "FT"  # Set the manager to "HR"
    cursor.execute(update_query, (manager, claimid))
    mydb.commit()

    print(f"Claim with ClaimID {claimid} has been approved with manager set to 'FT'.")

    # Step 2: Get the latest DateOfChange and TimesRejected for the same ClaimID
    latest_status_info = get_latest_status_info(claimid)
    #latest_date_of_change = latest_status_info[0] if latest_status_info else None
    times_rejected = latest_status_info[1] if latest_status_info else 0

    # Step 3: Insert a new entry into the Status table
    new_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, Manager, TimesRejected) VALUES (%s, %s, %s, %s, %s, %s)"
    status_date_of_change = date.today().strftime('%Y-%m-%d')
    manager = "HR"
    cursor.execute(new_status_query, (claimid, 0, status_date_of_change, managerempid, manager, times_rejected))
    mydb.commit()

    print(f"New entry added into Status table with ClaimID {claimid}, Status = 0, TimesRejected = {times_rejected}, and Manager = 'HR'.")

    querry2= "INSERT INTO RateCard (RateCardID,ClaimID,CardInsertionDate,InsertedBy_emp_id) VALUES (%s, %s, %s, %s)"

    cursor.execute("SELECT IFNULL(MAX(RateCardID) + 1, 1) FROM RateCard")
    rateid = cursor.fetchone()[0]

    cursor.execute(querry2,(rateid,claimid,status_date_of_change,managerempid))
    mydb.commit()

#approve("1","10")


def reject(claimid, managerempid):
    cursor = mydb.cursor()

    # Step 1: Update the manager field for the given ClaimID in the Claim table
    update_query = "UPDATE Claim SET ClaimStatus = %s , manager=null WHERE ClaimID = %s"
    sta = "-1"  
    cursor.execute(update_query, (sta, claimid))
    mydb.commit()

    print(f"Claim with ClaimID {claimid} has been rejected by manager 'HR'.")

    # Step 2: Get the latest DateOfChange and TimesRejected for the same ClaimID
    latest_status_info = get_latest_status_info(claimid)
    #latest_date_of_change = latest_status_info[0] if latest_status_info else None
    times_rejected = latest_status_info[1] if latest_status_info else 0

    # Step 3: Insert a new entry into the Status table
    new_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, Manager, TimesRejected) VALUES (%s,  %s, %s, %s, %s, %s)"
    status_date_of_change = date.today().strftime('%Y-%m-%d')
    manager = "HR"
    cursor.execute(new_status_query, (claimid, -1, status_date_of_change, managerempid, manager, times_rejected+1))
    mydb.commit()

    print(f"New entry added into Status table with ClaimID {claimid}, Status = -1, TimesRejected = {times_rejected+1}, and Manager = 'HR'.") 

#reject("1","10")  


def referback(claimid, managerempid, remark):
    cursor = mydb.cursor()

    # Step 1: Set ClaimStatus as -2 in the Claim table
    update_claim_status_query = "UPDATE Claim SET ClaimStatus = -2 WHERE ClaimID = %s"
    cursor.execute(update_claim_status_query, (claimid,))
    mydb.commit()

    # Step 2: Create a new entry in the Status table
    latest_status_info = get_latest_status_info(claimid)
    #latest_date_of_change = latest_status_info[0] if latest_status_info else None
    times_rejected = latest_status_info[1] if latest_status_info else 0

    insert_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, TimesRejected,manager) VALUES (%s, -2, %s, %s, %s,%s)"
    today_date = date.today().strftime('%Y-%m-%d')
    manag='HR'
    cursor.execute(insert_status_query, (claimid, today_date, managerempid,times_rejected+1,manag))
    mydb.commit()

    # Step 3: Create a new entry in the Recovery table
    cursor.execute("select max(DisputeID) from Recovery")
    dispute_id = cursor.fetchone()[0]
    dispute_id=dispute_id+1
    insert_recovery_query = "INSERT INTO Recovery (DisputeID, ClaimID, Remarks) VALUES (%s, %s, %s)"
    cursor.execute(insert_recovery_query, (dispute_id, claimid, remark))
    mydb.commit()

    print("Referback process completed successfully.")


# claim_id = 1
# manager_emp_id = 10
# remark = "Refer back for further review"
# referback(claim_id, manager_emp_id, remark)
