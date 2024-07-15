import datetime
from datetime import date
import openpyxl
import mysql.connector
import pandas as pd
mydb= mysql.connector.connect(host="localhost",user="root",passwd="anjuli2012",database="rct")

mycursor=mydb.cursor()

def useridpass( id,  passw):
    querry= "SELECT COUNT(*) AS row_count FROM Vendor WHERE VendorPass = '" +passw+ "' AND VendorID = "+id
    mycursor.execute(querry)
    myresult= mycursor.fetchone()
    ans=0
    for row in myresult:
        ans=row
    if(ans>=1):
        print("got it")
    else:
        print("sorry")

#useridpass("1","abc")


def listofclaims(vendorid):
    person_names = []
    person_ids = []
    statuses = []
    dates = []
    claimids=[]
    managers=[]
    k="SELECT ClaimID,PersonID, ClaimStatus,generationdate,manager FROM Claim where VendorID = " + vendorid
    mycursor.execute(k)
    claim_data = mycursor.fetchall()
    for row in claim_data:
        claimid,person_id, status,date,mane = row
        claimids.append(claimid)
        person_ids.append(person_id)
        statuses.append(status)
        dates.append(date)
        managers.append(mane)

        mycursor.execute("SELECT PersonName FROM EmployeeMaster WHERE PersonID = %s", (person_id,))
        person_name = mycursor.fetchone()
        if person_name:
            person_names.append(person_name[0])
        else:
            person_names.append("Unknown") 
    return person_names,person_ids,statuses,dates,managers,claimids

person_names,person_ids,statuses,dates,managers,claimids=listofclaims("3")

#print(person_names)

def getstatus(statuses):
    status_list = ["Pending" if status == 0 else "Approved" if status == 1 else "Rejected" if status==-1 else "referback" if status==-2 else "closed" for status in statuses]
    return status_list

#print(getstatus(statuses))

def filternames(person_names,person_ids,statuses,dates,managers,claimids):
    sorted_indices = sorted(range(len(person_names)), key=lambda i: person_names[i])
    person_names = sorted(person_names)
    person_ids = [person_ids[i] for i in sorted_indices]
    statuses = [statuses[i] for i in sorted_indices]
    dates = [dates[i] for i in sorted_indices]
    managers=[managers[i] for i in sorted_indices]
    claimids=[claimids[i] for i in sorted_indices]
    return person_names,person_ids,statuses,dates,managers,claimids

#person_names,person_ids,statuses,dates,managers,claimids=filternames(person_names,person_ids,statuses,dates,managers,claimids)
#print(person_ids)



def filterdates(person_names,person_ids,statuses,dates,managers,claimids):

    sorted_indices = sorted(range(len(dates)), key=lambda i: dates[i], reverse=True)
    dates = [dates[i] for i in sorted_indices]

    person_names = [person_names[i] for i in sorted_indices]
    person_ids = [person_ids[i] for i in sorted_indices]
    statuses = [statuses[i] for i in sorted_indices]
    managers=[managers[i] for i in sorted_indices]
    claimids=[claimids[i] for i in sorted_indices]
    return person_names,person_ids,statuses,dates,managers,claimids

#person_names,person_ids,statuses,dates,managers,claimids=filterdates(person_names,person_ids,statuses,dates,managers,claimids)
#print(managers)


def filterid(person_names,person_ids,statuses,dates,managers,claimids):
    sorted_indices = sorted(range(len(person_ids)), key=lambda i: person_ids[i])
    person_names = [person_names[i] for i in sorted_indices]
    person_ids = [person_ids[i] for i in sorted_indices]
    statuses = [statuses[i] for i in sorted_indices]
    dates = [dates[i] for i in sorted_indices]
    managers=[managers[i] for i in sorted_indices]
    claimids=[claimids[i] for i in sorted_indices]
    return person_names,person_ids,statuses,dates,managers,claimids

#person_names,person_ids,statuses,dates,managers,claimids=filterid(person_names,person_ids,statuses,dates,managers,claimids)
#print(managers)


def statusrefer(person_names,person_ids,statuses,dates,managers,claimids,value):
    filtered_indices = [i for i, status in enumerate(getstatus(statuses)) if status == value]
    print(statuses)
    person_names = [person_names[i] for i in filtered_indices]
    person_ids = [person_ids[i] for i in filtered_indices]
    statuses = [statuses[i] for i in filtered_indices]
    dates = [dates[i] for i in filtered_indices]
    managers=[managers[i] for i in filtered_indices]
    claimids=[claimids[i] for i in filtered_indices]
    return person_names,person_ids,statuses,dates,managers,claimids

#person_names,person_ids,statuses,dates,managers,claimids=statusrefer(person_names,person_ids,statuses,dates,managers,claimids,"Approved")
#print(person_names)

def download(person_names,person_ids,statuses,dates,managers):
    data = {
    "person_names": person_names,
    "person_ids": person_ids,
    "statuses": statuses,
    "dates": dates,
    "managers":managers
    }
    df = pd.DataFrame(data)
    file_path = r"C:\Users\ridit\Downloads\excelfile\venderdatafile.xlsx"
    df.to_excel(file_path, index=False)
    
#download(person_names,person_ids,getstatus(statuses),dates,managers)


def addnewclaim(PersonID, PersonDateOfHiring, VendorID, PersonSkill, Experience, Refraldoc):
    cursor = mydb.cursor()

    emp_query = "SELECT * FROM EmployeeMaster WHERE PersonID = %s AND VendorID = %s AND PersonDateOfHiring = %s"
    cursor.execute(emp_query, (PersonID, VendorID, PersonDateOfHiring))
    result = cursor.fetchall()

    if len(result) > 0:
        claim_query = "INSERT INTO Claim (ClaimID, PersonID,VendorID, ClaimStatus, generationdate, Refraldoc, PersonSkill, PersonXp, manager,PersonDateOfHiring) VALUES (%s, %s , %s, %s, %s, %s, %s, %s, %s,%s)"

        cursor.execute("SELECT IFNULL(MAX(ClaimID) + 1, 1) FROM Claim")
        claim_id = cursor.fetchone()[0]

        generation_date = date.today().strftime('%Y-%m-%d')

        cursor.execute(claim_query, (claim_id, PersonID,VendorID, 0, generation_date, Refraldoc, PersonSkill, Experience, "SV",PersonDateOfHiring))
        mydb.commit()

        print(f"New claim added with ClaimID: {claim_id}")


 
    else:
        print("Employee with the given PersonID, VendorID, and PersonDateOfHiring does not exist.")


#addnewclaim("2","2022-02-01","1","ds","1","aa")

def viewdetail(PersonID):
    cursor = mydb.cursor()

    emp_query = "SELECT PersonID, PersonName, VendorID FROM EmployeeMaster WHERE PersonID = %s"
    cursor.execute(emp_query, (PersonID,))
    emp_result = cursor.fetchone()

    if not emp_result:
        print("PersonID not found in EmployeeMaster.")
        return

    PersonID, PersonName, VendorID = emp_result

    claim_query = "SELECT ClaimStatus, generationdate FROM Claim WHERE PersonID = %s"
    cursor.execute(claim_query, (PersonID,))
    claim_result = cursor.fetchone()

    if not claim_result:
        print("No claim found for the given PersonID.")
        return

    ClaimStatus, generationdate = claim_result

    recovery_query = "SELECT Remarks FROM Recovery WHERE ClaimID = (SELECT ClaimID FROM Claim WHERE PersonID = %s)"
    cursor.execute(recovery_query, (PersonID,))
    recovery_result = cursor.fetchone()

    Remarks = recovery_result[0] if recovery_result else "No Remarks Found"

    print("PersonID:", PersonID)
    print("PersonName:", PersonName)
    print("VendorID:", VendorID)
    print("ClaimStatus:", ClaimStatus)
    print("Generation Date:", generationdate)
    print("Remarks:", Remarks)

viewdetail(3)



mycursor.close()
mydb.close()

