import datetime
from datetime import date
import openpyxl
import mysql.connector
import pandas as pd
mydb= mysql.connector.connect(host="localhost",user="root",passwd="anjuli2012",database="rct")


mycursor=mydb.cursor()


def get_latest_status_info(claimid):
    cursor = mydb.cursor()
    status_query = "SELECT DateOfChange, TimesRejected FROM Status WHERE ClaimID = %s ORDER BY DateOfChange DESC LIMIT 1"
    cursor.execute(status_query, (claimid,))
    result = cursor.fetchone()
    cursor.close()
    return result

def approve(claimid, managerempid,amount):
    cursor = mydb.cursor()

    update_query = "UPDATE Claim SET ClaimStatus = %s WHERE ClaimID = %s"
    manager = "1"  
    cursor.execute(update_query, (manager, claimid))
    mydb.commit()

    print(f"Claim with ClaimID {claimid} has been approved by manager 'FT'.")

    latest_status_info = get_latest_status_info(claimid)
    times_rejected = latest_status_info[1] if latest_status_info else 0

    new_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, Manager, TimesRejected) VALUES (%s, %s, %s, %s, %s, %s)"
    status_date_of_change = date.today().strftime('%Y-%m-%d')
    manager = "FT"
    cursor.execute(new_status_query, (claimid, 1, status_date_of_change, managerempid, manager, times_rejected))
    mydb.commit()

    print(f"New entry added into Status table with ClaimID {claimid}, Status = 0, TimesRejected = {times_rejected}, and Manager = 'FT'.")

    querry2= "UPDATE RateCard SET CardModificationDate = %s , ModifiedBy_emp_id = %s , Amount = %s where ClaimID = %s"


    cursor.execute(querry2,(status_date_of_change,managerempid,amount,claimid))
    mydb.commit()

#approve("1","10","20000")


def reject(claimid, managerempid):
    cursor = mydb.cursor()

    update_query = "UPDATE Claim SET ClaimStatus = %s , manager=null WHERE ClaimID = %s"
    sta = "-1"  
    cursor.execute(update_query, (sta, claimid))
    mydb.commit()

    print(f"Claim with ClaimID {claimid} has been rejected by manager 'FT'.")

    latest_status_info = get_latest_status_info(claimid)
    times_rejected = latest_status_info[1] if latest_status_info else 0

    new_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, Manager, TimesRejected) VALUES (%s,  %s, %s, %s, %s, %s)"
    status_date_of_change = date.today().strftime('%Y-%m-%d')
    manager = "FT"
    cursor.execute(new_status_query, (claimid, -1, status_date_of_change, managerempid, manager, times_rejected+1))
    mydb.commit()

    print(f"New entry added into Status table with ClaimID {claimid}, Status = -1, TimesRejected = {times_rejected+1}, and Manager = 'FT'.") 

#reject("1","10")  


def referback(claimid, managerempid, remark):
    cursor = mydb.cursor()

    update_claim_status_query = "UPDATE Claim SET ClaimStatus = -2 WHERE ClaimID = %s"
    cursor.execute(update_claim_status_query, (claimid,))
    mydb.commit()

    latest_status_info = get_latest_status_info(claimid)
    times_rejected = latest_status_info[1] if latest_status_info else 0

    insert_status_query = "INSERT INTO Status (ClaimID, Status, DateOfChange, ChangedBy_emp_id, TimesRejected,manager) VALUES (%s, -2, %s, %s, %s,%s)"
    today_date = date.today().strftime('%Y-%m-%d')
    manag='FT'
    cursor.execute(insert_status_query, (claimid, today_date, managerempid,times_rejected+1,manag))
    mydb.commit()

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