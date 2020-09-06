
# Lab: Azure DevOps Jenkins Lab Running on Containers


### EXERCISE 1: Prepare the Environment

#### Task 1: Create the VM

1.  Create a vm that supports containers. Please run command below on  **Bash** command of azure.


```sh
curl -O https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/ContainerVm.bash
ls -la ContainerVm.bash
chmod +x ContainerVm.bash
./ContainerVm.bash
#
```
![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/01-Bash.png)


#### Task 2: Set up VM To provide Containers Service

1.  Select **Virtual machines** and, on the **Virtual machines** blade,
    select **Jen-VM**.

1.  Select **Networking**.

1.  Select **Connect**, in the drop-down menu, select **RDP**, and then
    click **Download RDP File**.

1.  When prompted, sign in with the following credentials:

    -   User Name: **QA**
    -   Password: **1q2w3e4r5t6y\***
    

   > **Important Note:** All the actions you will follow including this step will be done on this Remote Computer's Console.

5.  Within the Remote Desktop session run the following command in **PowerShell** to create the guest vm to protect.  

6.  The installer will ask for your confirmation, click **OK** to complete the installation.  

    >**Note:** This will install docker Desktop to that VM, installation will take 3-4 minutes
    
7.  Click **Close and Restart** *when prompted*.
    
    
    ```powershell
    Set-NetFirewallProfile -Enabled False
    cd\
    mkdir SC
    $url = "https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/DL-DocDT.ps1"
    $output = "C:\SC\DockerDL.ps1"
    Invoke-WebRequest -Uri $url -OutFile $output
    Start-Sleep -s 5
    Start-Process Powershell.exe -Argumentlist "-file C:\SC\DockerDL.ps1"
    #

    ```
    
8.  Sign in again to that VM again, follow the steps 1-4 on this task.

9.  You will be using this remote console on the rest of the exercises of this lab

10. Wait for the services start, ignore prompt for update, click **Skip This BUild**

#### Task 3: -- Create Azure Project

1.  [Create My Shuttle Project for this Lab](https://azuredevopsdemogenerator.azurewebsites.net/?Name=MyShuttle)

>**Important Note:** You may have already done Task 3 if you are following the course excel file. 

### EXERCISE 2: Set Up Jenkins
>
#### Task 1: -- Download and Start Jenkins

1.  Run this command below on the command prompt to download the Jenkins image

**docker pull jenkins/jenkins:latest**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/02.01-DLJenkins.png)


2.  After download completed, we are ready to start the Jenkins image.

3.  Run the command below to list the downloaded images

**docker images**

4.  Run the command below to present the running images, this will return an empty list.

**docker ps**

5.  Run the command below to start Jenkins from port 8888

**docker run -d -p 8888:8080 \--name Jens jenkins/jenkins:latest**

6.  Run the command below to present the running images, this list the image you started on previous step.

**docker ps**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/02.02-DLJenkins.png)

7.  Time to visit the Jenkins page, leave command prompt open.

8.  Open a chrome browser window and visit <http://localhost:8888/> address, better to set as default. 

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/03-UnlockJenkins.png)

9.  We need the activate with administrator password

10.  Go back to command prompt and run the command below to access the Linux console

**docker exec -it Jens bash**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/04-ExecJenkins.png)


11.  We are now on Jenkins Linux bash console

12.  Run the command below to display administrator password for initial configuration

**cat var/jenkins_home/secrets/initialAdminPassword**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/05-InitialAdminPass.png)

13. Copy the Key and paste onto **Unlock Jenkins** screen inside **Adninistrator Password** field and click **Continue** to start initial setup of Jenkins

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/02.03-UnlockJenkins.png)
    
14. Choose **Install** **Suggested Plugins**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/06-CustomizeJenkins.png)

15. After the installation, create your user account on Jenkins, save and continue

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/07-FirstAdmin.png)

16. Confirm the step and click continue

17. Click **Start using Jenkins**

#### Task 2: -- Installing and Configuring Plugins

1.  We will now install the Maven and VSTS plugins that are needed for this lab.
    
2.  Click **Manage Jenkins** on the Jenkins home page and select **Manage Plugins**. Select the **Available** tab and search
    for team services
    
  
![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/08-ManageJenkins.png)

3.  Search for **VS Team Services Continuous Deployment** plugin and click **Install without restart**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/09-VSTeamSrv.png)


4.  Search for **Maven Integration Plugin** and **Install without restart**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/10-Maven.png)


5.  Once the plugin is installed, go back to **Manage Jenkins** and select the **Global Tool Configuration** option.
    
6.  Under **Global Tool Configuration**, Maven, choose the version 3.6.3, provide a name and **Save**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/11-MavenVer.png)


7.  Navigate **Back to the Dashboard** 

#### Task 3: -- Creating a new build job in Jenkins

1.  Click on the **New Item** link. Provide a name for the build definition, select **Maven project** and click **OK**. (Type
    something to distinguish the names with Jenkins e.g **MS-Jen)**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/12-EnterItemName.png)


2.  Under **Source Code Management**, choose **Git**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/13-SourceCodeMan.png)


3.  Jenkins needs access to the repository to build your project.

4.  On a different tab; Navigate to Repository under your **My Shuttle Project**
    
5.  Click clone repository and **Generate Git Credentials**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/14-CloneRepo.png)


6.  Go back to Jenkins tab and fill in the URL field and add the credentials

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/15-AddCreds.png)


7.  On the new window, fill in the user and the password field with the credentials from your repo
    
8.  Choose the newly created credentials to complete authentication

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/16-CompleteAuth.png)

9.  Scroll down to the **Build** section and provide the text **package -Dtest=FaresTest,SimpleTest** in the **Goals and options** field.

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/17-Build.png)

10. Scroll down to the **Post-build Actions** and choose the **Archive the artifacts** option.
    
11. Enter **target/\*.war, \*.sql** in the **Files to archive** text box.

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/18-PostBuild.png)

12. Select the **Save** button to save the settings and return to the project page
    
13. The configuration is completed, Select the **Build Now** on the menu left.  
    
14. Observe the results.

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/19-Build-No1.png)

### EXERCISE 3: Trigger Jenkins build from Azure Devops

#### Task 1: -- Approach 1: Creating a service hook in Azure DevOps

1.  Navigate to the Azure DevOps project settings page and select **Service hooks** under **General**. Select **+ Create
    subscription**
    
2.  Choose **Jenkins** from the list and click **Next**

3.  Choose **Code Pushed** for event type and, **MyShuttle** for repository and leave the value as Any for other fields and click **Next**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/20.01-Filters.png)


4.  You will need you public-Ip address to provide [click here](https://www.google.com/search?q=what+is+my+ip&oq=what&aqs=chrome.0.69i59j69i57j0l3j69i61l3.1566j0j1&sourceid=chrome&ie=UTF-8) to get your public Ip address.
    
    a.  Or visit what is my ip on the vm which holds Jenkins container to get the Ip address

    b.  add :8888 to the end of the ip address
    
    >**Note:** As mentioned on section a above, please keep using the remote computer. 
    
c.  It will be like <http://YourRemoteServerPublicIp:8888>
    
d.  Record this value, you will use this value as your **Jenkins Base URL**
    
5.  Go to Jenkins tab and click your user name on top right corner.

6.  Click **Configure** on the left pane.

7.  Create a new API Token, click **Add new Token**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/21-ApiToken.png)


8.  Type something to identify the token and click **Generate**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/22-GenToken.png)

9.  Copy the token and get back to **New Service Hooks Subscription** tab on Azure DevOps
    
10. Provide the values as address with 8888, username of Jenkins, and the token
    
11.  Choose the build available on Jenkins and click **Test** if everything is fine, click **Finish**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/23-Test-Finish.png)


12. Now we set up a connection to Jenkins from Azure Devops. Any change on the code should trigger a new build on Jenkins.
    
13. Try making a commit to the code - src/main/webapp/index.jsp would be a good candidate. This should trigger the build on Jenkins. You can confirm it by checking the history tab of the Jenkins services hook.
    
14. Go to Jenkins page and navigate to MS-Jen and check your builds.

15. 3 builds are listed. First one was the initial build, second is triggered when hook was created, third one is created after the
    step 13.

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/24-BuildHist.png)


#### Task 2: -- Approach 2: Wrapping Jenkins Job within Azure Pipelines

1.  Go to your project settings. Under **Pipelines** click **Service connections** and create **New service connection** for **Jenkins** click **Next**
    
2.  Provide the values as address with 8888, username of Jenkins, and the token
    
a.  **Server URL** public ip with :8888 appended
    
b.  Username, Jenkins image user account
    
c.  Password, Jenkins password

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/25-JenkinsSrvConn.png)


3.  Go to **Pipelines** and create a **New Pipeline** 

4.  Select Use the classic editor to create a pipeline.

5.  Select **Myshuttle** project, repository and click *Continue*.

6.  Search for **Jenkins** template and then click on **Apply**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/26-QueueJenkins.png)



7.  Provide the necessary information for the pipeline

    a.  Name is filled in Automatically.

    b.  Choose **vs2017-win2016** for Agent Pool

    c.  Provide a Job Name, use the same name on Jenkins, mine was  **MS-Jen**

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/27-JenkinsCI.png)


8.  Select the **Get Sources** step. Since Jenkins is being used for the build, no need to download the source code to the build agent. To skip syncing with the agent, select **Don't sync sources** option

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/28-DontSync.png)


9.  Next, select the **Queue Jenkins Job** step. This task queues the job on the Jenkins server. Make sure that the services endpoint and the job names are correct. The **Capture console output** and the **Capture pipeline output** options available at this step will be selected.
    
    a.  The **Capture console output and wait for completion** option, when selected, will capture the output of the Jenkins build console when the Azure build pipeline runs. The build will wait  until the Jenkins Job is completed.
    
    b.  The **Capture pipeline output and wait for pipeline completion** option is very similar but applies to Jenkins
    pipelines (a build that has more than one job nested together).

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/29-Capture.png)



10. The **Jenkins Download Artifacts** task will download the build artifacts from the Jenkins job to the staging directory

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/30-SaveTo.png)


11. The **Publish Artifact drop** will publish to Azure Pipelines.

12. Click on Save & queue button to save. Provide the Save Comment and Run.
    
13. Can you fix the error, to see the builds on Jenkins?

![](https://raw.githubusercontent.com/cemvarol/AZ-400-JenkinsLab/master/31-Output.png)


### EXERCISE 4: Remove the resources created for this Lab
>
#### Task 1: Delete the resource group

1.  On the Remote Computer session, navigate to [Azure Portal](https://portal.azure.com), click **Resource Groups** and delete the **Jenkins** Resource Group

>**Important Note:** This will disconnect the session and delete the remote computer that you are connected.

