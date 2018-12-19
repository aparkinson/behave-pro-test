Feature: APS Manual Workflows

 
  @EXARI-11932 @EXARI-12918 @assignee:sreedhar.arudra @version:7.5.0 @ORPHAN @testEXARI11932_3
  Scenario Outline: Verifies that single user workflows cannot be started without mandatory fields

    Given i_Create contract on testname "testEXARI11932_3" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "testEXARI11932_3"
               |username|testEXARI11932_3_user|
               |password|changeme1|
    When user click "Start Workflow" action
    Then aps_Select the process "<Workflow>"
    Then aps_Assert Start Process button is disabled
    Then aps_Select "<Priority>" from the priority list
    Then aps_Assert Start Process button is disabled  
    Then aps_Enter the due date "<Due_Date>"
    #EXARI-12918 blocking next step
    Then aps_Assert Start Process button is disabled
    Then aps_Select the following reviewers "<Reviewer>" for workflow "<Workflow>"
    Then aps_Assert that the Start Process button has been enabled
    Then aps_Switch back to contracts
    Then logout from application 
        
    Examples:	   
         	|Workflow|Due_Date|Priority|Reviewer|
         	|Ad hoc Pooled Review and Approve|23-DEC-2018|High|testEXARI11932_3_user|
         	|Ad hoc Review and Approve|23-DEC-2018|High|testEXARI11932_3_user|


  @EXARI-11932 @EXARI-12103 @EXARI-12437 @EXARI-12592 @EXARI-12607 @assignee:fran.hudson @assignee:sreedhar.arudra @version:7.5.0 @version:7.5.1 @ORPHAN @testEXARI11932_6
  Scenario Outline: Verify that when Adhoc Parallel Review And Approve Workflow  is started an email is triggered to all the receivers and also verify the content of the email

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                    Given cd_Contract details opened on testname "<test_name>"
                          |username|testEXARI11932_6_user_sender|
                          |password|changeme1|
                    When user click "Start Workflow" action
                    Then aps_Select a process and enter form details as:
        			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                    Then aps_Click on Start Process
            		Then cmn_Wait 2 seconds
            		Then aps_Switch back to contracts
            		Then cmn_Wait 5 seconds
                    Then logout from application             
        			## Confirm emails are received by reviewers
    				# Email not in junk folder - EXARI-12607
        	 		Then aps_check email contents for username "testEXARI11932_6_1@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_6_1@exari.com@exari.com                                                               |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_6 reviewer email test</p>                                                                 |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
                	Then aps_check email contents for username "testEXARI11932_6_2@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_6_2@exari.com@exari.com                                                               |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_6 reviewer email test</p>                                                                 |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
    				Examples:
          			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
          			|testEXARI11932_6| Ad hoc Parallel Review and Approve | testEXARI11932_6 reviewer email test | 29-MAR-2020 | Medium |100 | testEXARI11932_6_user_receiver1,testEXARI11932_6_user_receiver2 |	50|Mar 29 2020 |


  @EXARI-11932 @EXARI-12437 @assignee:sreedhar.arudra @version:7.5.0 @COMPLETED @testEXARI11932_7
  Scenario Outline: Verify the links in the email of the Adhoc Parallel Review and Approve workflow

        Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
        Given cd_Contract details opened on testname "<test_name>"
           |username|testEXARI11932_7_user_sender|
           |password|changeme1|
        When user click "Start Workflow" action
        Then aps_Select a process and enter form details as:
       	  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
        Then aps_Click on Start Process
        Then cmn_Wait 90 seconds
      	Then aps_Switch back to contracts
      	Then cmn_Wait 5 seconds
        Then logout from application  
        Then ma_log into Contracts with user:
           	|username|testEXARI11932_7_user_receiver1|
           	|password|changeme1|
        Then ma_select Mass Actions option        
      	## Select email links
      	Then aps_check email contents for username "testEXARI11932_7_1@exari.com" and password "P@ssw0rd@321"                                                                    
        |ContractLink|Draft Master Capture|
       	|TaskLink|Ad hoc Parallel Review and Approve|
        Examples:
        |test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
        |testEXARI11932_7| Ad hoc Parallel Review and Approve | testEXARI11932_7 reviewer email link test | 29-MAR-2020 | Medium |100 | testEXARI11932_7_user_receiver1,testEXARI11932_7_user_receiver2 |	50|Mar 29 2020 |


  @EXARI-11932 @EXARI-12103 @EXARI-12437 @EXARI-12592 @EXARI-12607 @EXARI-12681 @EXARI-12931 @assignee:fran.hudson @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11932_13
  Scenario Outline: Verify that when Adhoc Pooled Review And Approve  Workflow  is started an email is triggered to all the receivers and also verify the content of the email

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                    Given cd_Contract details opened on testname "<test_name>"
                          |username|testEXARI11932_13_user_sender|
                          |password|changeme1|
                    When user click "Start Workflow" action
                    Then aps_Select a process and enter form details as:
        			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                    Then aps_Click on Start Process
            		Then cmn_Wait 2 seconds
            		Then aps_Switch back to contracts
            		Then cmn_Wait 5 seconds
                    Then logout from application             
        			## Confirm emails are received by reviewers
    				# Email not in junk folder - EXARI-12607
        	 		Then aps_check email contents for username "testEXARI11932_13@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_13@exari.com@exari.com                                                              |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_13 reviewer email test</p>                                                                |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
    				Examples:
          			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
    				|testEXARI11932_13| Ad hoc Pooled Review and Approve | testEXARI11932_13 reviewer email test | 29-APR-2020 | Low |100 | testEXARI11932_13_Group |	1|Apr 29 2020|


  @EXARI-11932 @EXARI-12437 @assignee:sreedhar.arudra @version:7.5.0 @COMPLETED @testEXARI11932_14
  Scenario Outline: Verify the links in the email of the Adhoc Pooled Review And Approve workflow

        Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
        Given cd_Contract details opened on testname "<test_name>"
           |username|testEXARI11932_14_user_sender|
           |password|changeme1|
        When user click "Start Workflow" action
        Then aps_Select a process and enter form details as:
       	  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
        Then aps_Click on Start Process
        Then cmn_Wait 90 seconds
      	Then aps_Switch back to contracts
      	Then cmn_Wait 5 seconds
        Then logout from application  
        Then ma_log into Contracts with user:
           	|username|testEXARI11932_14_user_receiver|
           	|password|changeme1|
        Then ma_select Mass Actions option        
      	## Select email links
      	Then aps_check email contents for username "testEXARI11932_14@exari.com" and password "P@ssw0rd@321"                                                                    
        |ContractLink|Draft Master Capture            |
       	|TaskLink|Ad hoc Pooled Review and Approve|
       	Examples:
       	|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
        |testEXARI11932_14| Ad hoc Pooled Review and Approve | testEXARI11932_14 reviewer email link test | 29-APR-2020 | Low |100 | testEXARI11932_14_Group |	1|Apr 29 2020|


  @EXARI-11932 @EXARI-12103 @EXARI-12437 @EXARI-12592 @EXARI-12607 @assignee:fran.hudson @assignee:sreedhar.arudra @version:7.5.0 @version:7.5.1 @ORPHAN @testEXARI11932_20
  Scenario Outline: Verify that when Adhoc Review And Approve  Workflow  is started an email is triggered to all the receivers and also verify the content of the email

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                    Given cd_Contract details opened on testname "<test_name>"
                          |username|testEXARI11932_20_user_sender|
                          |password|changeme1|
                    When user click "Start Workflow" action
                    Then aps_Select a process and enter form details as:
        			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                    Then aps_Click on Start Process
            		Then cmn_Wait 2 seconds
            		Then aps_Switch back to contracts
            		Then cmn_Wait 5 seconds
                    Then logout from application             
        			## Confirm emails are received by reviewers
    				# Email not in junk folder - EXARI-12607
        	 		Then aps_check email contents for username "testEXARI11932_20@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_20@exari.com@exari.com                                                               |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_20 reviewer email test</p>                                                                 |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
    				Examples:
          			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
    				|testEXARI11932_20| Ad hoc Review and Approve | testEXARI11932_20 reviewer email test | 29-MAY-2020 | Low |100 | testEXARI13004_20_user_receiver1|	1|May 29 2020|


  @EXARI-11932 @EXARI-12437 @assignee:sreedhar.arudra @version:7.5.0 @COMPLETED @testEXARI11932_21
  Scenario Outline: Verify the links in the email of the Adhoc Review And Approve workflow

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
        Given cd_Contract details opened on testname "<test_name>"
           |username|testEXARI11932_21_user_sender|
           |password|changeme1|
        When user click "Start Workflow" action
        Then aps_Select a process and enter form details as:
       	  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
        Then aps_Click on Start Process
        Then cmn_Wait 90 seconds
      	Then aps_Switch back to contracts
      	Then cmn_Wait 5 seconds
        Then logout from application  
        Then ma_log into Contracts with user:
           	|username|testEXARI11932_21_user_receiver|
           	|password|changeme1|
        Then ma_select Mass Actions option        
      	## Select email links
      	Then aps_check email contents for username "testEXARI11932_21@exari.com" and password "P@ssw0rd@321"                                                                    
        |ContractLink|Draft Master Capture     |
       	|TaskLink|Ad hoc Review and Approve|
        Examples:
       	|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
       	|testEXARI11932_21| Ad hoc Review and Approve | testEXARI11932_21 reviewer email test | 29-MAY-2020 | Low |100 | testEXARI11932_21_user_receiver|	1|May 29 2020|


  @EXARI-11932 @EXARI-12103 @EXARI-12437 @EXARI-12592 @EXARI-12607 @EXARI-12681 @EXARI-12931 @assignee:fran.hudson @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11932_27
  Scenario Outline: Verify that when Parallel Group Review And Approve workflow is started an email is triggered to all the receivers and also verify the content of the email

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                    Given cd_Contract details opened on testname "<test_name>"
                          |username|testEXARI11932_27_user_sender|
                          |password|changeme1|
                    When user click "Start Workflow" action
                    Then aps_Select a process and enter form details as:
        			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                    Then aps_Click on Start Process
            		Then cmn_Wait 2 seconds
            		Then aps_Switch back to contracts
            		Then cmn_Wait 5 seconds
                    Then logout from application             
        			## Confirm emails are received by reviewers
    				# Email not in junk folder - EXARI-12607
        	 		Then aps_check email contents for username "testEXARI11932_27_1@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_27_1@exari.com@exari.com                                                              |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_27 reviewer email test</p>                                                                |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
    				Then aps_check email contents for username "testEXARI11932_27_2@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_27_2@exari.com@exari.com                                                              |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_27 reviewer email test</p>                                                                |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
    				Examples:
          			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
    				|testEXARI11932_27| Parallel Group Review and Approve | testEXARI11932_27 reviewer email test | 29-FEB-2020 | High |100 | testEXARI11932_27_Group1,testEXARI11932_27_Group2 |	100|Feb 29 2020 |


  @EXARI-11932 @EXARI-12437 @assignee:sreedhar.arudra @version:7.5.0 @COMPLETED @testEXARI11932_28
  Scenario Outline: Verify the links in the email of the Parallel Group Review And Approve workflow

        Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
        Given cd_Contract details opened on testname "<test_name>"
           |username|testEXARI11932_28_user_sender|
           |password|changeme1|
        When user click "Start Workflow" action
        Then aps_Select a process and enter form details as:
       	  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
        Then aps_Click on Start Process
        Then cmn_Wait 90 seconds
      	Then aps_Switch back to contracts
      	Then cmn_Wait 5 seconds
        Then logout from application  
        Then ma_log into Contracts with user:
           	|username|testEXARI11932_28_user_receiver1|
           	|password|changeme1                       |
        Then ma_select Mass Actions option        
      	## Select email links
      	Then aps_check email contents for username "testEXARI11932_28@exari.com" and password "P@ssw0rd@321"                                                                    
        |ContractLink|Draft Master Capture             |
       	|TaskLink|Parallel Group Review and Approve|
       	Examples:
       	|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
       	|testEXARI11932_28| Parallel Group Review and Approve | testEXARI11932_28 reviewer email test | 29-FEB-2020 | High |100 | testEXARI11932_28_Group1,testEXARI11932_28_Group2 |	100|Feb 29 2020 |


  @EXARI-11932 @EXARI-12103 @EXARI-12437 @EXARI-12592 @EXARI-12607 @EXARI-12681 @EXARI-12931 @assignee:fran.hudson @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11932_34
  Scenario Outline: Verify that when Serial Group Review And Approve workflow is started an email is triggered to all the receivers

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                    Given cd_Contract details opened on testname "<test_name>"
                          |username|testEXARI11932_34_user_sender|
                          |password|changeme1|
                    When user click "Start Workflow" action
                    Then aps_Select a process and enter form details as:
        			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                    Then aps_Click on Start Process
            		Then cmn_Wait 2 seconds
            		Then aps_Switch back to contracts
            		Then cmn_Wait 5 seconds
                    Then logout from application             
        			## Confirm emails are received by reviewers
    				# Email not in junk folder - EXARI-12607
        	 		Then aps_check email contents for username "testEXARI11932_34_1@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_34_1@exari.com@exari.com                                                              |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_34 reviewer email test</p>                                                                |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
    				Then aps_check email contents for username "testEXARI11932_34_2@exari.com" and password "P@ssw0rd@321"
        	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
        			|To                                                                                                                                |testexari11932_34_2@exari.com@exari.com                                                              |
        			|Subject                                                                                                                           |Review Task                                                                                                 |
        			|Message                                                                                                                           |New Review Task                                                                                             |
        			|Message                                                                                                                           |This task has been assigned to you.                                                                         |
        			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
                    |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
        			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
        			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
        			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
        			|Message                                                                                                                           |<p>testEXARI11932_34 reviewer email test</p>                                                                |
        			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
        			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
        			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
        			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
        			|Message                                                                                                                           |<p>Sincerely,<br>                                             Administrator                                 |
        			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
        			|AttachmentCount                                                                                                                   |0                                                                                                           |
    				Examples:
          			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
    				|testEXARI11932_34| Serial Group Review and Approve | testEXARI11932_34 reviewer email test | 29-JUN-2020 | High |100 | testEXARI11932_34_Group1,testEXARI11932_34_Group2 |	100|Jun 29 2020|


  @EXARI-11932 @EXARI-12437 @assignee:sreedhar.arudra @version:7.5.0 @COMPLETED @testEXARI11932_35
  Scenario Outline: Verify the links in the email of the Serial Group Review And Approve workflow and also verify the content of the email

        Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
        Given cd_Contract details opened on testname "<test_name>"
           |username|testEXARI11932_35_user_sender|
           |password|changeme1|
        When user click "Start Workflow" action
        Then aps_Select a process and enter form details as:
       	  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
        Then aps_Click on Start Process
        Then cmn_Wait 90 seconds
      	Then aps_Switch back to contracts
      	Then cmn_Wait 5 seconds
        Then logout from application  
        Then ma_log into Contracts with user:
           	|username|testEXARI11932_35_user_receiver1|
           	|password|changeme1|
        Then ma_select Mass Actions option        
      	## Select email links
      	Then aps_check email contents for username "testEXARI11932_35_1@exari.com" and password "P@ssw0rd@321"                                                                    
        |ContractLink|Draft Master Capture|
       	|TaskLink|Serial Group Review and Approve|
        Examples:
        |test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
        |testEXARI11932_35| Serial Group Review and Approve | testEXARI11932_35 reviewer email test | 29-JUN-2020 | High |100 | testEXARI11932_35_Group1,testEXARI11932_35_Group2 |	100|Jun 29 2020|


  @EXARI-11774 @EXARI-11775 @EXARI-11777 @EXARI-11932 @EXARI-12101 @EXARI-12109 @EXARI-12625 @EXARI-12706 @EXARI-13713 @assignee:ahmad.altaani @assignee:david.webster @assignee:fran.hudson @assignee:jacopo.lanzoni @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11774_1
  Scenario Outline: Start Adhoc Parallel Review And Approve workflow and verify that the workflow appears under Tasks for the user who received the workflow to take actions on 

    Given i_Create contract on testname "testEXARI11774_1" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "testEXARI11774_1"
       |username|test11774_1_user1|
       |password|changeme1|
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "test11774_1_user2" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_1"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_1_user2 Test|Running|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|Parallel Review Form|
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "testEXARI11774_1" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    #FOR EXARI-11775
    # Check that the task has disappeared from the My Tasks screen
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    
    Examples:
     | Process | Message | Due_Date | Priority | Percentage | Reviewers | Priority_Numeric | Due_Date_Displayed | Action | SuperUserName | Password |
     |Ad hoc Parallel Review and Approve|testEXARI11774_1 for Approve|25-DEC-2018|Medium|50|test11774_1_user1,test11774_1_user2|50|Dec 25 2018|Approve|||
     |Ad hoc Parallel Review and Approve|testEXARI11774_1 for Reject|25-DEC-2018|Low|50|test11774_1_user1,test11774_1_user2|1|Dec 25 2018|Reject|||
     |Ad hoc Parallel Review and Approve|testEXARI11774_1 for Promote|25-DEC-2018|High|50|test11774_1_user1,test11774_1_user2|100|Dec 25 2018|Promote|test11774_1_superuser|pwd|


  @EXARI-11774 @EXARI-11932 @EXARI-12109 @EXARI-12625 @EXARI-12706 @EXARI-13713 @assignee:david.webster @assignee:fran.hudson @assignee:jacopo.lanzoni @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11774_2
  Scenario Outline: Start Adhoc Pooled Review And Approve workflow and verify that the workflow appears under My Tasks for the user who received the workflow to take actions on

    Given i_Create contract on testname "testEXARI11774_2" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "testEXARI11774_2"
      |username|test11774_2_user1|
      |password|changeme1|
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    # login test11774_2_user2 - is member of test11774_Group1
    Given user is logged in with "test11774_2_user2" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_2"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_2"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_2_user2 Test|Running|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|ReviewForm|
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "testEXARI11774_2" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    
    Examples:
    	| Process | Message | Due_Date | Priority | Percentage | Reviewer | Priority_Numeric | Due_Date_Displayed | Action | SuperUserName | Password |
      |Ad hoc Pooled Review and Approve|Testing for Approve action|25-DEC-2018|Medium||test11774_Group1|50|Dec 25 2018|Approve|||
      |Ad hoc Pooled Review and Approve|Testing for Reject action|25-DEC-2018|Low||test11774_Group1|1|Dec 25 2018|Reject|||
      |Ad hoc Pooled Review and Approve|Testing for Promote action|25-DEC-2018|High||test11774_Group1|100|Dec 25 2018|Promote|test11774_2_superuser|pwd|


  @EXARI-11769 @EXARI-11774 @EXARI-11932 @EXARI-12109 @EXARI-12625 @EXARI-12706 @EXARI-13713 @assignee:david.webster @assignee:fran.hudson @assignee:jacopo.lanzoni @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11774_3
  Scenario Outline: Start Adhoc Review And Approve workflow and verify that the workflow appears under My Tasks for the user who received the workflow to take actions on

    Given i_Create contract on testname "testEXARI11774_3" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "testEXARI11774_3"
      |username|test11774_3_user1|
      |password|changeme1|
    Then cd_Click on Start Workflow
    #EXARI-11932
    #Can we check the URL here to make sure it DOESN NOT CONTAIN activiti
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "test11774_3_user2" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_3"
    Then aps_Check task Details shown are as:
     # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
       |<Reviewer>|Running|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|ReviewForm|
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "testEXARI11774_3" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    
    Examples:
         | Process | Message | Due_Date | Priority | Percentage | Reviewer | Priority_Numeric | Due_Date_Displayed | Action | SuperUserName | Password |
         |Ad hoc Review and Approve|testEXARI11774_3 for Approve|25-DEC-2018|Medium||test11774_3_user2 Test|50|Dec 25 2018|Approve|||
         |Ad hoc Review and Approve|testEXARI11774_3 for Reject|25-DEC-2018|Low||test11774_3_user2 Test|1|Dec 25 2018|Reject|||
         |Ad hoc Review and Approve|testEXARI11774_3 for Promote|25-DEC-2018|High||test11774_3_user2 Test|100|Dec 25 2018|Promote|test11774_3_superuser|pwd|


  @EXARI-11774 @EXARI-11932 @EXARI-12101 @EXARI-12109 @EXARI-12625 @EXARI-12706 @EXARI-13713 @assignee:david.webster @assignee:fran.hudson @assignee:jacopo.lanzoni @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11774_4
  Scenario Outline: Start Parallel Group Review And Approve workflow and verify that the workflow appears under My Tasks for the user who received the workflow to take actions on

    Given i_Create contract on testname "testEXARI11774_4" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "testEXARI11774_4"
     |username|test11774_4_user1|
     |password|changeme1|
    Then cd_Click on Start Workflow
    #EXARI-11932
    #Can we check the URL here to make sure it DOESN NOT CONTAIN activiti
    Then aps_Select a process and enter form details as:
       |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    # login test11774_4_user2 - who is in test11774_Group1
    Given user is logged in with "test11774_4_user2" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_4"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_4"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_4_user2 Test|Running|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|Parallel Review Form|
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "testEXARI11774_4" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    # login test11774_4_user3 - who is in test11774_Group2
    Given user is logged in with "test11774_4_user3" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_4"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_4"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_4_user3 Test|Running|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|Parallel Review Form|
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "Approve" button on the task form with testname "testEXARI11774_4" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Click on back button on the task form
    Then aps_Click on Completed Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_4"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_4_user3 Test|Completed|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|Parallel Review Form|
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    
    Examples:
      | Process | Message | Due_Date | Priority | Percentage | Reviewers | Priority_Numeric | Due_Date_Displayed | Action | SuperUserName | Password |
      |Parallel Group Review and Approve|Testing for Approve action|25-DEC-2018|Medium|100|test11774_Group1,test11774_Group2|50|Dec 25 2018|Approve|||
      |Parallel Group Review and Approve|Testing for Reject action|25-DEC-2018|Low|50|test11774_Group1,test11774_Group2|1|Dec 25 2018|Reject|||
    	|Parallel Group Review and Approve|Testing for Promote action|25-DEC-2018|High|100|test11774_Group1,test11774_Group2|100|Dec 25 2018|Promote|test11774_4_superuser|pwd|


  @EXARI-11774 @EXARI-11932 @EXARI-12101 @EXARI-12109 @EXARI-12625 @EXARI-12706 @EXARI-13713 @assignee:david.webster @assignee:fran.hudson @assignee:jacopo.lanzoni @assignee:sreedhar.arudra @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11774_5
  Scenario Outline: Start Serial Group Review And Approve workflow and verify that the workflow under My Tasks for the user who received the workflow to take actions on

    Given i_Create contract on testname "testEXARI11774_5" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "testEXARI11774_5"
      |username|test11774_5_user1|
      |password|changeme1|
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
       |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    # login test11774_5_user2 - who is in test11774_Group2
    Given user is logged in with "test11774_5_user2" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_5"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_5"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_5_user2 Test|Running|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|Parallel Review Form|
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "testEXARI11774_5" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    # FOR EXARI-11775
    # Check that the task has disappeared from the My Tasks screen
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    # login test11774_5_user3 - who is in test11774_Group1
    Given user is logged in with "test11774_5_user3" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_5"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_5"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_5_user3 Test|Running|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|Parallel Review Form|
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "Approve" button on the task form with testname "testEXARI11774_5" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Click on back button on the task form
    Then aps_Click on Completed Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11774_5"
    Then aps_Check task Details shown are as:
    # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
      |test11774_5_user3 Test|Completed|<Priority_Numeric>|<Due_Date_Displayed>|No category|<Process>|<Message>|Parallel Review Form|
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    
    Examples:
     | Process | Message | Due_Date | Priority | Percentage | Reviewers | Priority_Numeric | Due_Date_Displayed | Action | SuperUserName | Password |
     |Serial Group Review and Approve|Testing for Approve action|25-DEC-2018|Medium|100|test11774_Group2,test11774_Group1|50|Dec 25 2018|Approve|||
     |Serial Group Review and Approve|Testing for Reject action|25-DEC-2018|Low|50|test11774_Group2,test11774_Group1|1|Dec 25 2018|Reject|||
     |Serial Group Review and Approve|Testing for Promote action|25-DEC-2018|High|100|test11774_Group2,test11774_Group1|100|Dec 25 2018|Promote|test11774_5_superuser|pwd|


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_3
  Scenario Outline: Ad hoc Pooled Review and Approve - Verify the from email address of the email notification to sender when workflow is approved by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_3_user_sender|
          |password|changeme1                   |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_3_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_3@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_3@exari.com                                                                             |
    	       |Subject        |Review Task                                                                                            | 
    	       |Message        |Approved Task                                                                                          |
    	       |Message        |This task has been approved                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_3_sender for Approve</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Low                                                                           |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_3_user_sender Test </p>   |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	     | Process                         | Message                           | Due_Date  | Priority| Percentage  | Reviewers                                     | Priority_Numeric | Due_Date_Displayed | Action | SuperUserName | Password |
         |testEXARI13005_3|Ad hoc Pooled Review and Approve|testEXARI13005_3_sender for Approve|15-DEC-2021|Low     |50           |testEXARI13005_3_Group1|50|Dec 15 2021|Approve|||  


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_4
  Scenario Outline: Ad hoc Review and Approve - Verify the from email address of the email  notification  to sender when workflow is approved by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_4_user_sender|
          |password|changeme1                   |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_4_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_4@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_4@exari.com                                                                             |
    	       |Subject        |Review Task                                                                                            | 
    	       |Message        |Approved Task                                                                                          |
    	       |Message        |This task has been approved                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_4_sender for Approve</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Medium                                                                        |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_4_user_sender Test </p>   |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	      | Process                 | Message                           | Due_Date  | Priority| Percentage  | Reviewers                          | Priority_Numeric | Due_Date_Displayed| Action | SuperUserName | Password |
         |testEXARI13005_4|Ad hoc Review and Approve|testEXARI13005_4_sender for Approve|15-DEC-2021|Medium     |50           |testEXARI13005_4_user_receiver1 Test|50|Dec 15 2021  |Approve|||  


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_5
  Scenario Outline: Serial Group Review and Approve -Verify the from email address of the email  notification  to sender when workflow is approved by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_5_user_sender|
          |password|changeme1                   |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_5_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_5@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_5@exari.com                                                                             |
    	       |Subject        |Review Task                                                                                            | 
    	       |Message        |Approved Task                                                                                          |
    	       |Message        |This task has been approved                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_5_sender for Approve</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Low                                                                           |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_5_user_sender Test </p>   |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	     | Process                         | Message                           | Due_Date  | Priority| Percentage  | Reviewers                                     | Priority_Numeric | Due_Date_Displayed | Action | SuperUserName | Password |
         |testEXARI13005_5|Serial Group Review and Approve|testEXARI13005_5_sender for Approve|15-DEC-2021|Low     |50           |testEXARI13005_5_Group1,testEXARI13005_5_Group2|50|Dec 15 2021|Approve|||  


  @EXARI-12693 @EXARI-12702 @EXARI-13003 @assignee:Neil.Britton @assignee:fran.hudson @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI13003_6
  Scenario: Verify super user receives escalation email at midnight of the due date for Parallel Group Review and Approve workflow

    Given cmn_Need to Automate
    # Create contract
    # Select Start Workflow option
    # Select process (workflow) Parallel Group Review and Approve
    # Enter test 13003_6 at end of text in name (1st field)
    # Enter super user email test 13003_6 in the message text field
    # Select next day on on Due calendar
    # Select High from the Priority dropdown
    # Select Assignee
    # Select Start Process
    # Confirm super user email is received at midnight of the due date
    # Email details:
    # From: Exari Workflow <workflow@exari.com>
    ## EXARI-12702
    # Subject - FW: A task was created for the group Super_Users!
    # New Review Task - A task is created for the group 'Super_Users'!
    # The task 'Escalated Review Task' was created for a group you are a member of.
    # Message:
    # super user email test 13003_6
    # Priority: High
    # [Open the task] link
    # Sincerely, sender 'the super users name'
    # To obtain more details, visit Exari CM


  @EXARI-12693 @EXARI-12702 @EXARI-13003 @assignee:Neil.Britton @assignee:fran.hudson @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI13003_7
  Scenario: Verify super user receives escalation email at midnight of the due date for Ad hoc Parallel Review and Approve workflow

    Given cmn_Need to Automate
    # Create contract
    # Select Start Workflow option
    # Select process (workflow) Ad hoc Parallel Review and Approve
    # Enter test 13003_7 at end of text in name (1st field)
    # Enter super user email test 13003_7 in the message text field
    # Select next day on on Due calendar
    # Select Medium from the Priority dropdown
    # Select Assignee
    # Select Start Process
    # Confirm super user email is received at midnight of the due date
    # Email details:
    # From: Exari Workflow <workflow@exari.com>
    ## EXARI-12702
    # Subject - FW: A task was created for the group Super_Users!
    # New Review Task - A task is created for the group 'Super_Users'!
    # The task 'Escalated Review Task' was created for a group you are a member of.
    # Message:
    # super user email test 13003_7
    # Priority: Medium
    # [Open the task] link
    # Sincerely, sender 'the super users name'
    # To obtain more details, visit Exari CM


  @EXARI-12693 @EXARI-12702 @EXARI-13003 @assignee:Neil.Britton @assignee:fran.hudson @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI13003_8
  Scenario: Verify super user receives escalation email at midnight of the due date for Ad hoc Pooled Review and Approve workflow

    Given cmn_Need to Automate
    # Create contract
    # Select Start Workflow option
    # Select process (workflow) Ad hoc Pooled Review and Approve
    # Enter test 13003_8 at end of text in name (1st field)
    # Enter super user email test 13003_8 in the message text field
    # Select next day on on Due calendar
    # Select Low from the Priority dropdown
    # Select Assignee
    # Select Start Process
    # Confirm super user email is received at midnight of the due date
    # Email details:
    # From: Exari Workflow <workflow@exari.com>
    ## EXARI-12702
    # Subject - FW: A task was created for the group Super_Users!
    # New Review Task - A task is created for the group 'Super_Users'!
    # The task 'Escalated Review Task' was created for a group you are a member of.
    # Message:
    # super user email test 13003_8
    # Priority: Low
    # [Open the task] link
    # Sincerely, sender 'the super users name'
    # To obtain more details, visit Exari CM


  @EXARI-12693 @EXARI-12702 @EXARI-13003 @assignee:Neil.Britton @assignee:fran.hudson @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI13003_9
  Scenario: Verify super user receives escalation email at midnight of the due date for Ad hoc Review and Approve workflow

    Given cmn_Need to Automate
    # Create contract
    # Select Start Workflow option
    # Select process (workflow) Ad hoc Review and Approve
    # Enter test 13003_9 at end of text in name (1st field)
    # Enter super user email test 13003_9 in the message text field
    # Select next day on on Due calendar
    # Select High from the Priority dropdown
    # Select Assignee
    # Select Start Process
    # Confirm super user email is received at midnight of the due date
    # Email details:
    # From: Exari Workflow <workflow@exari.com>
    ## EXARI-12702
    # Subject - FW: A task was created for the group Super_Users!
    # New Review Task - A task is created for the group 'Super_Users'!
    # The task 'Escalated Review Task' was created for a group you are a member of.
    # Message:
    # super user email test 13003_9
    # Priority: High
    # [Open the task] link
    # Sincerely, sender 'the super users name'
    # To obtain more details, visit Exari CM


  @EXARI-12693 @EXARI-12702 @EXARI-13003 @assignee:Neil.Britton @assignee:fran.hudson @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI13003_10
  Scenario: Verify super user receives escalation email at midnight of the due date for Serial Group Review And Approve workflow

    Given cmn_Need to Automate
    # Create contract
    # Select Start Workflow option
    # Select process (workflow) Serial Group Review And Approve
    # Enter test 13003_10 at end of text in name (1st field)
    # Enter super user email test 13003_10 in the message text field
    # Select next day on on Due calendar
    # Select Medium from the Priority dropdown
    # Select Assignee
    # Select Start Process
    # Confirm super user email is received at midnight of the due date
    # Email details:
    # From: Exari Workflow <workflow@exari.com>
    ## EXARI-12702
    # Subject - FW: A task was created for the group Super_Users!
    # New Review Task - A task is created for the group 'Super_Users'!
    # The task 'Escalated Review Task' was created for a group you are a member of.
    # Message:
    # super user email test 13003_10
    # Priority: Medium
    # [Open the task] link
    # Sincerely, sender 'the super users name'
    # To obtain more details, visit Exari CM


  @EXARI-12687 @EXARI-13002 @EXARI-13004 @EXARI-13026 @EXARI-13409 @assignee:fran.hudson @version:7.5.1 @ORPHAN @testEXARI13004_6
  Scenario Outline: Verify super user receives escalation email and task when receiver promotes a Parallel Group Review and Approve workflow task

        	    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                Given cd_Contract details opened on testname "<test_name>"
                      |username|testEXARI13004_6_user_sender|
                      |password|changeme1|
                When user click "Start Workflow" action
                Then aps_Select a process and enter form details as:
    			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                Then aps_Click on Start Process
        		Then cmn_Wait 2 seconds
        		Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
                Then logout from application
                Given user is logged in with "testEXARI13004_6_user_receiver1" and "changeme1"
              	Then cmn_Wait 5 seconds
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
             	Then aps_Click on tasks on the left hand side menu
    	        Then aps_Click on Queued Tasks on the left hand side menu
    	        Then aps_Select task "Review Task" on task list for testname "<test_name>"
      			Then aps_Click on the claim button for the selected task
        		Then aps_Click on My Tasks on the left hand side menu
                Then aps_Select task "Review Task" on task list for testname "<test_name>"
        	    Then aps_Click on Actions on task list side bar
        	    Then aps_Click on Open Form on the task list side bar
        	    Then aps_Select task option "Promote" on action form
        	    Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
        	 	Then logout from application
                Given user is logged in with "testEXARI13004_6_super_user" and "changeme1"
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
                Then aps_Click on tasks on the left hand side menu
                Then aps_Click on Queued Tasks on the left hand side menu
    			Then aps_Assert that "Queued Tasks" is the active tab under Tasks      
                ## EXARI-12875 - Confirm the same task is displayed in the queued list
               Then aps_Select Created column header on task list
               Then aps_Select Created column header on task list
                Then aps_Select task "Escalated Review Task" on task list for testname "<test_name>"
                # EXARI-12687 & 13409
    ###			Then aps_Check task Details shown are as:
      			  # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
    ###			 |No assignee|Running|<Priority_Numeric>|<New_Due_Date>|No category|<Process>|<Message>| Parallel Escalated Review Form|       
    			## EXARI-13026 - Confirm super user email is received
          ## EXARI-13002 - Verify From address on email
    		 	Then aps_check email contents for username "testEXARI13004_6@exari.com" and password "P@ssw0rd@321"
    			|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
    			|To                                                                                                                                |testexari13004_6@exari.com                                                                                  |
    			|Subject                                                                                                                           |A task was created for the group Super_Users!                                                               |
    			|Message                                                                                                                           |New Review Task - A task is created for the group 'Super_Users'!                                            |
    			|Message                                                                                                                           |The task 'Escalated Review Task' was created for a group you are a member of.                               |
    			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
          |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
    			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
    			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
    			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
    			|Message                                                                                                                           |<p>testEXARI13004_6 promote to super user test</p>                                                          |
    			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
    			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;High                                                                            |
    			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
    			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
    			|Message                                                                                                                           |<p>Sincerely,<br>                                             testEXARI13004_6_user_sender Test </p>        |
    			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
    			|AttachmentCount                                                                                                                   |0                                                                                                           |
            	Examples:
      			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
      			|testEXARI13004_6| Parallel Group Review and Approve | testEXARI13004_6 promote to super user test | 29-FEB-2020 | High |100 | testEXARI13004_6_Group1,testEXARI13004_6_Group2 |	100|Feb 29 2020 |


  @EXARI-12687 @EXARI-13002 @EXARI-13004 @EXARI-13026 @EXARI-13409 @assignee:fran.hudson @version:7.5.1 @ORPHAN @testEXARI13004_7
  Scenario Outline: Verify super user receives escalation email and task when receiver promotes a Ad hoc Parallel Review and Approve workflow task

     Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                Given cd_Contract details opened on testname "<test_name>"
                      |username|testEXARI13004_7_user_sender|
                      |password|changeme1|
                When user click "Start Workflow" action
                Then aps_Select a process and enter form details as:
    			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                Then aps_Click on Start Process
        		Then cmn_Wait 2 seconds
        		Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
                Then logout from application
                Given user is logged in with "testEXARI13004_7_user_receiver1" and "changeme1"
             	Then cmn_Wait 5 seconds
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
        		Then aps_Click on My Tasks on the left hand side menu
                Then aps_Select task "Review Task" on task list for testname "<test_name>"
        	    Then aps_Click on Actions on task list side bar
        	    Then aps_Click on Open Form on the task list side bar
        	    Then aps_Select task option "Promote" on action form
        	    Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
        	 	Then logout from application
                Given user is logged in with "testEXARI13004_7_super_user" and "changeme1"
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
                Then aps_Click on tasks on the left hand side menu
                Then aps_Click on Queued Tasks on the left hand side menu
    			Then aps_Assert that "Queued Tasks" is the active tab under Tasks
                ## EXARI-12875 - Confirm the same task is displayed in the queued list
                Then aps_Select Created column header on task list
                Then aps_Select Created column header on task list
                Then aps_Select task "Escalated Review Task" on task list for testname "<test_name>"
                # EXARI-12687 & 13409
    ###			Then aps_Check task Details shown are as:
      		  # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
    ###			  |No assignee|Running|<Priority_Numeric>|<New_Due_Date>|No category|<Process>|<Message>| Parallel Escalated Review Form|   
    			## EXARI-13026 - Confirm super user email is received
          ## EXARI-13002 - Verify From address on email
    	 		Then aps_check email contents for username "testEXARI13004_7@exari.com" and password "P@ssw0rd@321"
    	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
    			|To                                                                                                                                |testexari13004_7@exari.com                                                                                  |
    			|Subject                                                                                                                           |A task was created for the group Super_Users!                                                               |
    			|Message                                                                                                                           |New Review Task - A task is created for the group 'Super_Users'!                                            |
    			|Message                                                                                                                           |The task 'Escalated Review Task' was created for a group you are a member of.                               |
    			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
          |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
    			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
    			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
    			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
    			|Message                                                                                                                           |<p>testEXARI13004_7 promote to super user test</p>                                                          |
    			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
    			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Medium                                                                          |
    			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
    			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
    			|Message                                                                                                                           |<p>Sincerely,<br>                                             testEXARI13004_7_user_sender Test </p>        |
    			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
    			|AttachmentCount                                                                                                                   |0                                                                                                           |
            	Examples:
      			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
      			|testEXARI13004_7| Ad hoc Parallel Review and Approve | testEXARI13004_7 promote to super user test | 29-MAR-2020 | Medium |100 | testEXARI13004_7_user_receiver1,testEXARI13004_7_user_receiver2 |	50|Mar 29 2020 | |


  @EXARI-12687 @EXARI-13002 @EXARI-13004 @EXARI-13026 @assignee:fran.hudson @version:7.5.1 @ORPHAN @testEXARI13004_8
  Scenario Outline: Verify super user receives escalation email and task when receiver promotes a Ad hoc Pooled Review and Approve workflow task

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                Given cd_Contract details opened on testname "<test_name>"
                      |username|testEXARI13004_8_user_sender|
                      |password|changeme1|
                When user click "Start Workflow" action
                Then aps_Select a process and enter form details as:
    			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                Then aps_Click on Start Process
        		Then cmn_Wait 2 seconds
        		Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
                Then logout from application
                Given user is logged in with "testEXARI13004_8_user_receiver1" and "changeme1"
             	Then cmn_Wait 5 seconds
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
        		Then aps_Click on Queued Tasks on the left hand side menu
                Then aps_Select task "Review Task" on task list for testname "<test_name>"
              	Then aps_Click on the claim button for the selected task
                Then aps_Click on My Tasks on the left hand side menu
                Then aps_Select task "Review Task" on task list for testname "<test_name>"
        	    Then aps_Click on Actions on task list side bar
        	    Then aps_Click on Open Form on the task list side bar
        	    Then aps_Select task option "Promote" on action form
        	    Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
        	 	Then logout from application
                Given user is logged in with "testEXARI13004_8_super_user" and "changeme1"
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
                Then aps_Click on tasks on the left hand side menu
                Then aps_Click on Queued Tasks on the left hand side menu
    			Then aps_Assert that "Queued Tasks" is the active tab under Tasks
                ## EXARI-12875 - Confirm the same task is displayed in the queued list
                Then aps_Select Created column header on task list
                Then aps_Select Created column header on task list
                Then aps_Select task "Escalated Review Task" on task list for testname "<test_name>"
                # EXARI-12687
    ###			Then aps_Check task Details shown are as:
      		  # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
    ###			 |No assignee|Running|<Priority_Numeric>|<New_Due_Date>|No category|<Process>|<Message>| Escalated Review Form|    
    			## EXARI-13026 - Confirm super user email is received
          ## EXARI-13002 - Verify From address on email
    	 		Then aps_check email contents for username "testEXARI13004_8@exari.com" and password "P@ssw0rd@321"
    	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
    			|To                                                                                                                                |testexari13004_8@exari.com                                                                                  |
    			|Subject                                                                                                                           |A task was created for the group Super_Users!                                                               |
    			|Message                                                                                                                           |New Review Task - A task is created for the group 'Super_Users'!                                            |
    			|Message                                                                                                                           |The task 'Escalated Review Task' was created for a group you are a member of.                               |
    			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
          |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
    			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
    			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
    			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
    			|Message                                                                                                                           |<p>testEXARI13004_8 promote to super user test</p>                                                          |
    			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
    			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Low                                                                             |
    			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
    			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
    			|Message                                                                                                                           |<p>Sincerely,<br>                                             testEXARI13004_8_user_sender Test </p>        |
    			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
    			|AttachmentCount                                                                                                                   |0                                                                                                           |
            	Examples:
      			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
      			|testEXARI13004_8| Ad hoc Pooled Review and Approve | testEXARI13004_8 promote to super user test | 29-APR-2020 | Low |100 | testEXARI13004_8_Group |	1|Apr 29 2020|


  @EXARI-12687 @EXARI-13002 @EXARI-13004 @EXARI-13026 @assignee:fran.hudson @version:7.5.1 @ORPHAN @testEXARI13004_9
  Scenario Outline: Verify super user receives escalation email and task when receiver promotes a Ad hoc Review and Approve workflow task

        		Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                Given cd_Contract details opened on testname "<test_name>"
                      |username|testEXARI13004_9_user_sender|
                      |password|changeme1|
                When user click "Start Workflow" action
                Then aps_Select a process and enter form details as:
    			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                Then aps_Click on Start Process
        		Then cmn_Wait 2 seconds
        		Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
                Then logout from application
                Given user is logged in with "testEXARI13004_9_user_receiver1" and "changeme1"
             	Then cmn_Wait 5 seconds
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
        		Then aps_Click on My Tasks on the left hand side menu
                Then aps_Select task "Review Task" on task list for testname "<test_name>"
        	    Then aps_Click on Actions on task list side bar
        	    Then aps_Click on Open Form on the task list side bar
        	    Then aps_Select task option "Promote" on action form
        	    Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
        	 	Then logout from application
                Given user is logged in with "testEXARI13004_9_super_user" and "changeme1"
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
                Then aps_Click on tasks on the left hand side menu
                Then aps_Click on Queued Tasks on the left hand side menu
    			Then aps_Assert that "Queued Tasks" is the active tab under Tasks
                ## EXARI-12875 - Confirm the same task is displayed in the queued list
                Then aps_Select Created column header on task list
                Then aps_Select Created column header on task list
                Then aps_Select task "Escalated Review Task" on task list for testname "<test_name>"
                # EXARI-12687
    ###			Then aps_Check task Details shown are as:
    			  # |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
    ###			 |No assignee|Running|<Priority_Numeric>|<New_Due_Date>|No category|<Process>|<Message>| Escalated Review Form|   
    			## EXARI-13026 - Confirm super user email is received
          ## EXARI-13002 - Verify From address on email
    	 		Then aps_check email contents for username "testEXARI13004_9@exari.com" and password "P@ssw0rd@321"
    	 		|From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                         |
    			|To                                                                                                                                |testexari13004_9@exari.com                                                                                  |
    			|Subject                                                                                                                           |A task was created for the group Super_Users!                                                               |
    			|Message                                                                                                                           |New Review Task - A task is created for the group 'Super_Users'!                                            |
    			|Message                                                                                                                           |The task 'Escalated Review Task' was created for a group you are a member of.                               |
    			|Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                  |
          |Message                                                                                                                           |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/     |
    			|Message                                                                                                                           |Draft Master Capture</a></p>                                                                                |
    			|Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                              |
    			|Message                                                                                                                           |<p><b>Message:</b></p>                                                                                      |
    			|Message                                                                                                                           |<p>testEXARI13004_9 promote to super user test</p>                                                          |
    			|Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                     |
    			|Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;Low                                                                             |
    			|Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                        |
    			|Message                                                                                                                           |title="Open the task">Open the task</a>                                                                     |
    			|Message                                                                                                                           |<p>Sincerely,<br>                                             testEXARI13004_9_user_sender Test </p>        |
    			|Message                                                                                                                           |To obtain more details, visit Exari CM                                                                      |
    			|AttachmentCount                                                                                                                   |0                                                                                                           |
            	Examples:
      			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
      			|testEXARI13004_9| Ad hoc Review and Approve | testEXARI13004_9 promote to super user test | 29-MAY-2020 | Low |100 | testEXARI13004_9_user_receiver1|	1|May 29 2020|


  @EXARI-12687 @EXARI-13002 @EXARI-13004 @EXARI-13026 @EXARI-13409 @assignee:fran.hudson @version:7.5.1 @ORPHAN @testEXARI13004_10
  Scenario Outline: Verify super user receives escalation email and task when receiver promotes a Serial Group Review And Approve workflow task

    	Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
                Given cd_Contract details opened on testname "<test_name>"
                      |username|testEXARI13004_10_user_sender|
                      |password|changeme1                    |
                When user click "Start Workflow" action
                Then aps_Select a process and enter form details as:
    			  |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewer>|
                Then aps_Click on Start Process
        		Then cmn_Wait 2 seconds
        		Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
                Then logout from application
                Given user is logged in with "testEXARI13004_10_user_receiver1" and "changeme1"
              	Then cmn_Wait 5 seconds
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
             	Then aps_Click on tasks on the left hand side menu
    	        Then aps_Click on Queued Tasks on the left hand side menu
    	        Then aps_Select task "Review Task" on task list for testname "<test_name>"
      			Then aps_Click on the claim button for the selected task
        		Then aps_Click on My Tasks on the left hand side menu
                Then aps_Select task "Review Task" on task list for testname "<test_name>"
        	    Then aps_Click on Actions on task list side bar
        	    Then aps_Click on Open Form on the task list side bar
        	    Then aps_Select task option "Promote" on action form
        	    Then aps_Switch back to contracts
        		Then cmn_Wait 5 seconds
        	 	Then logout from application
                Given user is logged in with "testEXARI13004_10_super_user" and "changeme1"
                Then aps_Click on Activity Manager in Contracts
                Then aps_Click on Tasks in the activity manager dropdown in contracts
                Then aps_Click on tasks on the left hand side menu
                Then aps_Click on Queued Tasks on the left hand side menu
    			Then aps_Assert that "Queued Tasks" is the active tab under Tasks      
                ## EXARI-12875 - Confirm the same task is displayed in the queued list
               Then aps_Select Created column header on task list
               Then aps_Select Created column header on task list
                Then aps_Select task "Escalated Review Task" on task list for testname "<test_name>"
                # EXARI-12687 & 13409
    ###			Then aps_Check task Details shown are as:
      			# |Assignee|Status|Priority|Due Date|Category|Parent name|Description|Form Name|
    ###			  |No assignee|Running|<Priority_Numeric>|<New_Due_Date>|No category|<Process>|<Message>| Parallel Escalated Review Form|     
    			## EXARI-13026 - Confirm super user email is received
          ## EXARI-13002 - Verify From address on email
    		 	Then aps_check email contents for username "testEXARI13004_10@exari.com" and password "P@ssw0rd@321"
    			 |From                                                                                                                              |Exari Workflow <workflow@exari.com>                                                                       |
    			 |To                                                                                                                                |testexari13004_10@exari.com                                                                               |
    			 |Subject                                                                                                                           |A task was created for the group Super_Users!                                                             |
    			 |Message                                                                                                                           |New Review Task - A task is created for the group 'Super_Users'!                                          |
    			 |Message                                                                                                                           |The task 'Escalated Review Task' was created for a group you are a member of.                             |
    			 |Message                                                                                                                           |<p><b>Contract Name:</b> <a href="https://                                                                |
           |Message                                                                                                                           |exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/    |
    			 |Message                                                                                                                           |Draft Master Capture</a></p>                                                                              |
    			 |Message                                                                                                                           |<p><b>Contract Owner:</b> </p>                                                                            |
    			 |Message                                                                                                                           |<p><b>Message:</b></p>                                                                                    |
    			 |Message                                                                                                                           |<p>testEXARI13004_10 promote to super user test</p>                                                       |
    			 |Message                                                                                                                           |<b>Due:</b>&nbsp;&nbsp;                                                                                   |
    			 |Message                                                                                                                           |<b>Priority:</b>&nbsp;&nbsp;High                                                                          |
    			 |Message                                                                                                                           |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                      |
    			 |Message                                                                                                                           |title="Open the task">Open the task</a>                                                                   |
    			 |Message                                                                                                                           |<p>Sincerely,<br>                                             testEXARI13004_10_user_sender Test </p>     |
    			 |Message                                                                                                                           |To obtain more details, visit Exari CM                                                                    |
    			 |AttachmentCount                                                                                                                   |0                                                                                                         |
            	Examples:
      			|test_name| Process | Message | Due_Date | Priority | Percentage | Reviewer |Priority_Numeric|New_Due_Date|
      			|testEXARI13004_10| Serial Group Review and Approve | testEXARI13004_10 promote to super user test | 29-JUN-2020 | High |100 | testEXARI13004_10_Group1,testEXARI13004_10_Group2 |	100|Jun 29 2020|


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_2
  Scenario Outline: Ad hoc Parallel Review and Approve - Verify the from email address of the email notification to sender when workflow is approved by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_2_user_sender|
          |password|changeme1                   |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_2_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_2@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_2@exari.com                                                                             |
    	       |Subject        |Review Task                                                                                            | 
    	       |Message        |Approved Task                                                                                          |
    	       |Message        |This task has been approved                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_1_sender for Approve</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Medium                                                                        |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_2_user_sender Test </p>   |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	      | Process                          | Message                           | Due_Date  | Priority| Percentage  | Reviewers                                                               | Priority_Numeric | Due_Date_Displayed| Action | SuperUserName | Password |
         |testEXARI13005_2|Ad hoc Parallel Review and Approve|testEXARI13005_2_sender for Approve|15-DEC-2021|Medium     |50           |testEXARI13005_2_user_receiver1 Test,testEXARI13005_2_user_receiver2 Test|50|Dec 15 2021  |Approve|||  


  @EXARI-11769 @EXARI-11863 @EXARI-12671 @EXARI-12805 @EXARI-12967 @EXARI-12988 @EXARI-13344 @assignee:Neil.Britton @assignee:evan.greensmith @assignee:fran.hudson @assignee:jacopo.lanzoni @assignee:laura.roll @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11863_1
  Scenario Outline: Completes single user workflows, checking the start form and process diagram in Running, All and Complete Processes and checking workflow appears in the correct processes

    Given i_Create contract on testname "testEXARI1183_1" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Then aps_Open activity app URL and authenticate with user name "admin@app.activiti.com" and password "admin"
    Then cmn_Wait 2 seconds
    Given cd_Contract details opened on testname "testEXARI1183_1"
           |username|testEXARI11863_1_user_1|
           |password|changeme1|
    When user click "Start Workflow" action
    Then aps_Select a process and enter form details as:
      	   |<Workflow>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 10 seconds
    Then aps_Click on All processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI1183_1"
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Click on process diagram button on RHS details pane
    Then aps_Click on back button on the process diagram page
    Then aps_Click on Running processes on the LHS menu
    Then cmn_Wait 5 seconds
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI1183_1"
    Then cmn_Wait 5 seconds
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Click on process diagram button on RHS details pane
    Then aps_Assert that the process diagram has been displayed
    Then aps_Click on back button on the process diagram page
    Then aps_Switch back to contracts
    Then logout from application
    Given user is logged in with "testEXARI11863_1_user_2" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Processes in the activity manager dropdown in contracts
    Then aps_Click on Running processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI1183_1"
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Click on process diagram button on RHS details pane
    Then aps_Assert that the process diagram has been displayed
    Then aps_Click on back button on the process diagram page
    Then aps_Click on tasks on the left hand side menu
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI1183_1"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "Approve" button on the task form with testname "testEXARI1183_1" and super username "" and password ""
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then logout from application
    Given user is logged in with "testEXARI11863_1_user_1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Approved" on task list for testname "testEXARI1183_1"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "Complete" button on the task form with testname "" and super username "" and password ""
    Then aps_Click on processes on the left hand side menu
    Then aps_Click on Completed processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI1183_1"
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Close RHS details pane on the processes page
    Then aps_Click on All processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI1183_1"
    Then aps_Switch back to contracts
    Then logout from application
    	
    Examples: 
    		|Workflow|Message|Due_Date|Priority|Percentage|Reviewers|
    		|Ad hoc Review and Approve|testEXARI11836_1 message for Ad hoc Review and Approve|23-DEC-2018|Medium||testEXARI11863_1_user_2|
    		|Ad hoc Parallel Review and Approve|testEXARI11836_1 message for Ad hoc Parallel Review and Approve|23-DEC-2018|Medium|50|testEXARI11863_1_user_2,testEXARI11863_1_user_1|


  @EXARI-11863 @EXARI-12671 @EXARI-12805 @EXARI-12967 @EXARI-13344 @assignee:Neil.Britton @assignee:fran.hudson @assignee:jacopo.lanzoni @assignee:laura.roll @assignee:vadym.ilin @version:7.5.0 @version:7.5.1 @version:7.6.0 @ORPHAN @testEXARI11863_2
  Scenario Outline: Completes group workflows, checking the start form and process diagram in Running, All and Complete Processes and checking workflow appears in the correct processes

    Given i_Create contract on testname "testEXARI11863_2" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Then aps_Open activity app URL and authenticate with user name "admin@app.activiti.com" and password "admin"
    Then cmn_Wait 2 seconds
    Given cd_Contract details opened on testname "testEXARI11863_2"
           |username|testEXARI11863_2_user_1|
           |password|changeme1|
    When user click "Start Workflow" action
    Then aps_Select a process and enter form details as:
      	   |<Workflow>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 10 seconds
    Then aps_Click on All processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI11863_2"
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Click on process diagram button on RHS details pane
    Then aps_Click on back button on the process diagram page
    Then aps_Click on Running processes on the LHS menu
    Then cmn_Wait 10 seconds
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI11863_2"
    Then cmn_Wait 10 seconds
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Click on process diagram button on RHS details pane
    Then aps_Assert that the process diagram has been displayed
    Then aps_Click on back button on the process diagram page
    Then aps_Switch back to contracts
    Then logout from application
    Given user is logged in with "testEXARI11863_2_user_2" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Processes in the activity manager dropdown in contracts
    Then aps_Click on Running processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI11863_2"
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Click on process diagram button on RHS details pane
    Then aps_Assert that the process diagram has been displayed
    Then aps_Click on back button on the process diagram page
    Then aps_Click on tasks on the left hand side menu
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11863_2"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "testEXARI11863_2"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "Approve" button on the task form with testname "testEXARI11863_2" and super username "" and password ""
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then logout from application
    Given user is logged in with "testEXARI11863_2_user_1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Approved" on task list for testname "testEXARI11863_2"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "Complete" button on the task form with testname "" and super username "" and password ""
    Then aps_Click on processes on the left hand side menu
    Then aps_Click on Completed processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI11863_2"
    Then aps_Click on Start Form on the RHS details page
    Then aps_Assert that details in Start Form for "<Workflow>" workflow is correct:
    			||||<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>||
    Then aps_Close the Start Form pop up
    Then aps_Close RHS details pane on the processes page
    Then aps_Click on All processes on the LHS menu
    Then aps_Select process with workflow "<Workflow>" and testname "testEXARI11863_2"
    Then aps_Switch back to contracts
    Then logout from application
    	
    Examples: 
    		|Workflow|Message|Due_Date|Priority|Percentage|Reviewers|
    		|Parallel Group Review and Approve|testEXARI11863_2 message for Parallel Group Review and Approve|23-DEC-2018|High|50|testEXARI11863_2|
    		|Ad hoc Pooled Review and Approve|testEXARI11863_2 message for Ad hoc Pooled Review and Approve|23-DEC-2018|High|50|testEXARI11863_2|
    		|Serial Group Review and Approve|testEXARI11863_2 message for Serial Group Review and Approve|23-DEC-2018|High|50|testEXARI11863_2|


  @EXARI-11932 @EXARI-12918 @assignee:sreedhar.arudra @version:7.5.0 @ORPHAN @testEXARI11932_4
  Scenario Outline: Verifies that group workflows cannot be started without mandatory fields

    Given i_Create contract on testname "testEXARI11932_4" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "testEXARI11932_4"
               |username|testEXARI11932_4_user|
               |password|changeme1|
    When user click "Start Workflow" action
    Then aps_Select the process "<Workflow>"
    Then aps_Assert Start Process button is disabled
    Then aps_Enter the due date "<Due_Date>"
    Then aps_Assert Start Process button is disabled
    Then aps_Select "<Priority>" from the priority list
    Then aps_Assert Start Process button is disabled
    Then aps_Enter "90" in required approval percentage field
    #EXARI-12918 blocking next step
    Then aps_Assert Start Process button is disabled
    Then aps_Select the following reviewers "<Reviewer>" for workflow "<Workflow>"
    Then aps_Assert that the Start Process button has been enabled
    Then aps_Switch back to contracts
    Then logout from application 
            
    Examples:	   
         	|Workflow|Due_Date|Priority|Reviewer|
         	|Parallel Group Review and Approve|23-DEC-2018|High|Exari_Everyone|
         	|Ad hoc Parallel Review and Approve|23-DEC-2018|High|testEXARI11932_4_user|
         	|Serial Group Review and Approve|23-DEC-2018|High|Exari_Everyone|


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_1
  Scenario Outline: Parallel Group Review and Approve - Verify the from email address of the email notification to sender when workflow is approved by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_1_user_sender|
          |password|changeme1                   |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_1_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_1@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_1@exari.com                                                                             |
    	       |Subject        |Review Task                                                                                            | 
    	       |Message        |Approved Task                                                                                          |
    	       |Message        |This task has been approved                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_1_sender for Approve</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;High                                                                          |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_1_user_sender Test</p>    |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	     | Process                         | Message                           | Due_Date  | Priority| Percentage  | Reviewers                                     | Priority_Numeric | Due_Date_Displayed| Action| SuperUserName | Password |
         |testEXARI13005_1|Parallel Group Review and Approve|testEXARI13005_1_sender for Approve|15-DEC-2021|High     |50           |testEXARI13005_1_Group1,testEXARI13005_1_Group2|50|Dec 15 2021|Approve|||  


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_11
  Scenario Outline: Parallel Group Review and Approve - Verify the from email address of the email notification to sender when workflow is Rejected by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_11_user_sender|
          |password|changeme1                    |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_11_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_11@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_11@exari.com                                                                            |
    	       |Message        |Rejected Review Task                                                                                   |
    	       |Message        |This task has been rejected                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_11_sender for Reject</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;High                                                                          |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_11_user_sender Test </p>  |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	       | Process                         | Message                           | Due_Date  | Priority| Percentage  | Reviewers                                       | Priority_Numeric | Due_Date_Displayed| Action| SuperUserName | Password |
         |testEXARI13005_11|Parallel Group Review and Approve|testEXARI13005_11_sender for Reject|15-DEC-2021|High     |50           |testEXARI13005_11_Group1,testEXARI13005_11_Group2|50|Dec 15 2021|Reject |||  


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_12
  Scenario Outline: Ad hoc Parallel Review and Approve - Verify the from email address of the email notification to sender when workflow is Rejected by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_12_user_sender|
          |password|changeme1                    |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_12_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_12@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_12@exari.com                                                                            |
    	       |Message        |Rejected Review Task                                                                                   |
    	       |Message        |This task has been rejected                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_12_sender for Reject</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Medium                                                                        |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_12_user_sender Test </p>  |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	       | Process                          | Message                           | Due_Date  | Priority| Percentage  | Reviewers                                                                 | Priority_Numeric | Due_Date_Displayed| Action| SuperUserName | Password |
         |testEXARI13005_12|Ad hoc Parallel Review and Approve|testEXARI13005_12_sender for Reject|15-DEC-2021|Medium     |50           |testEXARI13005_12_user_receiver1 Test,testEXARI13005_12_user_receiver2 Test|50|Dec 15 2021  |Reject |||  


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_13
  Scenario Outline: Ad hoc Pooled Review and Approve - Verify the from email address of the email notification to sender when workflow is Rejected by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_13_user_sender|
          |password|changeme1                    |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_13_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_13@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_13@exari.com                                                                            |
    	       |Message        |Rejected Review Task                                                                                   |
    	       |Message        |This task has been rejected                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_13_sender for Reject</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Low                                                                           |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_13_user_sender Test </p>  |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	       | Process                         | Message                           | Due_Date  | Priority| Percentage  | Reviewers              | Priority_Numeric | Due_Date_Displayed | Action| SuperUserName | Password |
         |testEXARI13005_13|Ad hoc Pooled Review and Approve|testEXARI13005_13_sender for Reject|15-DEC-2021|Low     |50           |testEXARI13005_13_Group1|50|Dec 15 2021|Reject |||  


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_14
  Scenario Outline: Ad hoc Review and Approve - Verify the from email address of the email notification to sender when workflow is Rejected by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_14_user_sender|
          |password|changeme1                    |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_14_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_14@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_14@exari.com                                                                            |
    	       |Message        |Rejected Review Task                                                                                   |
    	       |Message        |This task has been Rejected                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_14_sender for Reject</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Medium                                                                        |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_14_user_sender Test </p>  |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	       | Process                 | Message                           | Due_Date  | Priority| Percentage  | Reviewers                           | Priority_Numeric | Due_Date_Displayed| Action| SuperUserName | Password |
         |testEXARI13005_14|Ad hoc Review and Approve|testEXARI13005_14_sender for Reject|15-DEC-2021|Medium     |50           |testEXARI13005_14_user_receiver1 Test|50|Dec 15 2021  |Reject |||  


  @EXARI-13005 @assignee:Neil.Britton @version:7.5.1 @COMPLETED @testEXARI13005_15
  Scenario Outline: Serial Group Review and Approve - Verify the from email address of the email notification to sender when workflow is Rejected by the receiver

    Given i_Create contract on testname "<test_name>" with documents "commonTestDocuments/Contracts/DraftMasterCapture/documentsWithAnswers.zip" and metadata "commonTestDocuments/Contracts/DraftMasterCapture/metadata.json"
    Given cd_Contract details opened on testname "<test_name>"
          |username|testEXARI13005_15_user_sender|
          |password|changeme1                    |
    Then cd_Click on Start Workflow
    Then aps_Select a process and enter form details as:
      |<Process>|<Message>|<Due_Date>|<Priority>|<Percentage>|<Reviewers>|
    Then aps_Click on Start Process
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
    Given user is logged in with "testEXARI13005_15_user_receiver1" and "changeme1"
    Then aps_Click on Activity Manager in Contracts
    Then aps_Click on Tasks in the activity manager dropdown in contracts
    Then aps_Click on Queued Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on the claim button for the selected task
    Then aps_Click on My Tasks on the left hand side menu
    Then aps_Select task "Review Task" on task list for testname "<test_name>"
    Then aps_Click on Actions on task list side bar
    Then aps_Click on Open Form on the task list side bar
    Then aps_Click on "<Action>" button on the task form with testname "<test_name>" and super username "<SuperUserName>" and password "<Password>"
    Then cmn_Wait 2 seconds
    Then aps_Switch back to contracts
    Then cmn_Wait 5 seconds
    Then logout from application
       # bug EXARI-13631 for contract Owner being blank in the email notification 
    Then aps_check email contents for username "testEXARI13005_15@exari.com" and password "P@ssw0rd@321"
    
               |From           |Exari Workflow <workflow@exari.com>                                                                    |
               |To             |testexari13005_15@exari.com                                                                            |
    	       |Message        |Rejected Review Task                                                                                   |
    	       |Message        |This task has been approved                                                                            |
               |Message        |<p><b>Contract Name:</b> <a href="https://                                                             |
               |Message        |.exaricontracts.com/exaricm/page/site/auto-tests-site/contract-details?nodeRef=workspace://SpacesStore/|
    	       |Message        |Draft Master Capture</a></p>                                                                           |
    	       |Message        |<p><b>Contract Owner:</b> </p>                                                                         |
    	       |Message        |<p><b>Message:</b></p>                                                                                 |
    	       |Message        |<p>testEXARI13005_15_sender for Reject</p>                                                             |
    	       |Message        |Priority:</b>&nbsp;&nbsp;Low                                                                           |                                                                                     
    	       |Message        |.exaricontracts.com/exaricm/page/activity-manager-app/#/taskdetails/                                   |
    	       |Message        |title="Open the task">Open the task</a>                                                                |
    	       |Message        |<p>Sincerely,<br>                                             testEXARI13005_15_user_sender Test </p>  |
    	       |Message        |To obtain more details, visit <a href="#">Exari CM</a>                                                 |
    	       |AttachmentCount|0                                                                                                      |
      # there is a bug that the under sincerely its always the initial of the of the workflow - EXARI-13110 
       Examples:
         |test_name	       | Process                         | Message                           | Due_Date  | Priority| Percentage  | Reviewers                                       | Priority_Numeric | Due_Date_Displayed | Action| SuperUserName | Password |
         |testEXARI13005_15|Serial Group Review and Approve|testEXARI13005_15_sender for Reject|15-DEC-2021|Low     |50           |testEXARI13005_15_Group1,testEXARI13005_15_Group2|50|Dec 15 2021|Reject |||  


  @EXARI-13916 @version:7.6.0 @ORPHAN @testEXARI13916
  Scenario: Viewing form in My Tasks, attachements are inherited from previous task

    Given cmn_Need to Automate
    #Create 2 users
    #Login as sender
    #Start a workflow with no attachments
    #Start a workflow with 1 attachment
    #Log out
    #Login with reciever
    #Go to My Tasks
    #Open the form for workflow with 1 attachment
    #Verfiy that attachment is displayed
    #Go back to My Tasks
    #Open the form for the workflow with no attachments
    #Verify that no attachments are displayed

