# Outage Simulation

## Introduction

This step showcases the a load file deployed to the application which will create a sudden increase in the API server request and we will see how the alarms firing works and we will notice the change in the dashboards.

Estimated Time: X minutes

### Objectives

In this lab, you will:
- Simulate An Error


## Task 1: Create Load

- Open the Cloud Shell
![](images/cs.png)
- Access the OKE cluster 
![](images/accesscluster.png)

- Create the load
    ```
    <copy>
    kubectl create -f https://raw.githubusercontent.com/oracle-quickstart/oci-cloudnative/master/src/load/load-dep.yaml

    </copy>
    ```
    ![](images/createload.png)

## Task 2: LA Dashboard

- After Some minutes you find changes in the views

    ![](images/editdashboard.png)

## Task 3: Check Firing Alarms

- From the Menu select **O&M > Monitoring > Alarm Status**
![](images/alarm.png)
- You will see the a firing alarm which you can find more information by clicking on it
![](images/alarm2.png)
- Check the email inbox you used creating the alarm to see the notification
![](images/emailnotif.png)
- Finally, remove the load created from the Cloud Shell
![](images/deleteload.png)

## **Acknowledgements**
  - **Author** - Rawan Aboukoura - Technology Product Strategy Manager, Victor Martin - Technology Product Strategy Manager 
  - **Contributors** -
  - **Last Updated By/Date** -
