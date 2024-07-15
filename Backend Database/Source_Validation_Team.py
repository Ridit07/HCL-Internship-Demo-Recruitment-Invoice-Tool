from datetime import date
import openpyxl
import mysql.connector
import pandas as pd
mydb= mysql.connector.connect(host="localhost",user="root",passwd="anjuli2012",database="rct")


mycursor=mydb.cursor()



def useridpass( id,  passw):
    querry= "SELECT COUNT(*) AS row_count FROM EmployeeMaster WHERE PersonPass = '" +passw+ "' AND PersonID = "+id +" AND PersonDeptId='1' "
    mycursor.execute(querry)
    myresult= mycursor.fetchone()
    ans=0
    for row in myresult:
        ans=row
    if(ans>=1):
        print("got it")
    else:
        print("sorry")

#useridpass("10","das")

def listofclaims():
    person_names = []
    person_ids = []
    dates = []
    vendors=[]
    claimids=[]
    mycursor.execute("SELECT PersonID,generationdate,VendorID,ClaimID FROM Claim where manager= 'SV' ")
    claim_data = mycursor.fetchall()
    for row in claim_data:
        person_id,date,vendor,claimid = row
        person_ids.append(person_id)
        dates.append(date)
        vendors.append(vendor)
        claimids.append(claimid)

        # Fetch PersonName from EmployeeMaster table based on PersonID
        mycursor.execute("SELECT PersonName FROM EmployeeMaster WHERE PersonID = %s", (person_id,))
        person_name = mycursor.fetchone()
        if person_name:
            person_names.append(person_name[0])
        else:
            person_names.append("Unknown")  # If PersonName is not found, add "Unknown"
    return person_names,person_ids,dates,vendors,claimids

person_names,person_ids,dates,vendors,claimids=listofclaims()

#print(claimids)

def vendordetails(claimid):
    cursor = mydb.cursor()

    # Step 1: Find the VendorID corresponding to the given ClaimID
    vendor_query = "SELECT VendorID FROM Claim WHERE ClaimID = %s"
    cursor.execute(vendor_query, (claimid,))
    vendor_result = cursor.fetchone()

    if not vendor_result:
        print(f"No Vendor found for ClaimID: {claimid}")
        return

    vendor_id = vendor_result[0]

    # Step 2: Retrieve the Vendor details from the Vendor table
    vendor_details_query = "SELECT VendorName, VendorEmailID, VendorPhoneNo FROM Vendor WHERE VendorID = %s"
    cursor.execute(vendor_details_query, (vendor_id,))
    vendor_details_result = cursor.fetchone()

    if not vendor_details_result:
        print(f"Vendor details not found for VendorID: {vendor_id}")
        return

    vendor_name, vendor_email, vendor_phone = vendor_details_result

    # Step 3: Retrieve the required details from the Claim table
    claim_query = "SELECT PersonSkill, PersonXp, PersonDateOfHiring FROM Claim WHERE ClaimID = %s"
    cursor.execute(claim_query, (claimid,))
    claim_result = cursor.fetchone()

    if not claim_result:
        print(f"No Claim found for ClaimID: {claimid}")
        return

    person_skill, person_xp, person_date_of_hiring = claim_result

    # Step 4: Print the details
    print("Vendor Details:")
    print("Vendor id:",vendor_id)
    print("Vendor Name:", vendor_name)
    print("Vendor Email:", vendor_email)
    print("Vendor Phone:", vendor_phone)

    print("Claim Details:")
    print("Person Skill:", person_skill)
    print("Person Experience:", person_xp)
    print("Person Date of Hiring:", person_date_of_hiring)


#vendordetails(1)

def employeetabledetails(claimid):
    cursor = mydb.cursor()

    # Step 1: Find the PersonID corresponding to the given ClaimID
    person_query = "SELECT PersonID FROM Claim WHERE ClaimID = %s"
    cursor.execute(person_query, (claimid,))
    person_result = cursor.fetchone()

    if not person_result:
        print(f"No Employee found for ClaimID: {claimid}")
        return

    person_id = person_result[0]

    # Step 2: Retrieve the Employee details from the EmployeeMaster table
    employee_details_query = "SELECT PersonID, PersonName, Person_RegionId, PersonEmailID, PersonDateOfHiring, PersonStatus, ContractDuration, PersonDeptID, PersonSkill, Experience FROM EmployeeMaster WHERE PersonID = %s"
    cursor.execute(employee_details_query, (person_id,))
    employee_details_result = cursor.fetchone()

    if not employee_details_result:
        print(f"Employee details not found for PersonID: {person_id}")
        return

    person_id, person_name, person_region, person_email, person_date_of_hiring, person_status, contact_duration, person_dept, person_skill, experience = employee_details_result

    # Step 3: Print the details
    print("Employee Details:")
    print("Person ID:", person_id)
    print("Person Name:", person_name)
    print("Person Region:", person_region)
    print("Person Email:", person_email)
    print("Person Date of Hiring:", person_date_of_hiring)
    print("Person Status:", person_status)
    print("Contact Duration:", contact_duration)
    print("Person Department:", person_dept)
    print("Person Skill:", person_skill)
    print("Experience:", experience)

#employeetabledetails(1)

#used in approve
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
    manager = "HR"  # Set the manager to "HR"
    cursor.execute(update_query, (manager, claimid))
    mydb.commit()

    print(f"Claim with ClaimID {claimid} has been approved with manager set to 'HR'.")

    # Step 2: Get the latest DateOfChange and TimesRejected for the same ClaimID
    latest_status_info = get_latest_status_info(claimid)
    #latest_date_of_change = latest_status_info[0] if latest_status_info else None
    times_rejected = latest_status_info[1] if latest_status_info else 0

    # Step 3: Insert a new entry into the Status table
    new_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, Manager, TimesRejected) VALUES (%s, %s, %s, %s, %s, %s)"
    status_date_of_change = date.today().strftime('%Y-%m-%d')
    manager = "SV"
    cursor.execute(new_status_query, (claimid, 0,  status_date_of_change, managerempid, manager, times_rejected))
    mydb.commit()

    print(f"New entry added into Status table with ClaimID {claimid}, Status = 0, TimesRejected = {times_rejected}, and Manager = 'SV'.")

#approve(1, 10)

def reject(claimid, managerempid):
    cursor = mydb.cursor()

    # Step 1: Update the manager field for the given ClaimID in the Claim table
    update_query = "UPDATE Claim SET ClaimStatus = %s , manager=null WHERE ClaimID = %s"
    sta = "-1"  
    cursor.execute(update_query, (sta, claimid))
    mydb.commit()

    print(f"Claim with ClaimID {claimid} has been rejected by manager 'SV'.")

    # Step 2: Get the latest DateOfChange and TimesRejected for the same ClaimID
    latest_status_info = get_latest_status_info(claimid)
    #latest_date_of_change = latest_status_info[0] if latest_status_info else None
    times_rejected = latest_status_info[1] if latest_status_info else 0

    # Step 3: Insert a new entry into the Status table
    new_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, Manager, TimesRejected) VALUES (%s, %s, %s, %s, %s, %s)"
    status_date_of_change = date.today().strftime('%Y-%m-%d')
    manager = "SV"
    cursor.execute(new_status_query, (claimid, -1, status_date_of_change, managerempid, manager, times_rejected+1))
    mydb.commit()

    print(f"New entry added into Status table with ClaimID {claimid}, Status = -1, TimesRejected = {times_rejected+1}, and Manager = 'SV'.")    


#reject("1","10")

def getemployeetable():
    cursor = mydb.cursor()

    # Step 1: Retrieve the complete EmployeeMaster table (excluding PersonPass)
    query = "SELECT PersonID, PersonName, VendorID, Person_RegionId, PersonSkill, Experience, PersonEmailID, PersonDateOfHiring, PersonStatus, ContractDuration, PersonDeptID,ExceptionalHiring,ExceptionReason FROM EmployeeMaster"
    cursor.execute(query)
    result = cursor.fetchall()

    # Step 2: Convert the result into a DataFrame using pandas
    columns = [desc[0] for desc in cursor.description]
    df = pd.DataFrame(result, columns=columns)

    # Step 3: Save the DataFrame to an Excel file
    file_path = r"C:\Users\ridit\Downloads\excelfile\employee_master.xlsx"
    df.to_excel(file_path, index=False)

    print("EmployeeMaster table has been saved as an Excel file.")


#getemployeetable()


def getvendortable():
    cursor = mydb.cursor()

    # Step 1: Retrieve the complete EmployeeMaster table (excluding PersonPass)
    query = "SELECT VendorID, VendorName, VendorEmailID, VendorPhoneNo FROM Vendor"
    cursor.execute(query)
    result = cursor.fetchall()

    # Step 2: Convert the result into a DataFrame using pandas
    columns = [desc[0] for desc in cursor.description]
    df = pd.DataFrame(result, columns=columns)

    # Step 3: Save the DataFrame to an Excel file
    file_path = r"C:\Users\ridit\Downloads\excelfile\vendor_master.xlsx"
    df.to_excel(file_path, index=False)

    print("Vendormaster table has been saved as an Excel file.")

#getvendortable()