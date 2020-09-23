RAIPS172 ;WOIFO/KLM-Rad/NM Post-init Driver, patch 172; Jul 13, 2020@15:08:20
 ;;5.0;Radiology/Nuclear Medicine;**172**;Mar 16, 1998;Build 1
 ;New standardized Cancel/Hold reasons
 ;
EN      ;Entry pt for post-install
 N RAI,RAREA,RAMSG
 F RAI=1:1 S RAREA=$T(REA+RAI) Q:RAREA=""  D
 .S RA01=$P(RAREA,";",3),RA3=$P(RAREA,";",4),RA2=$P(RAREA,";",5)
 .N RAFDA,RAR S RAR="RAFDA(75.2,""?+1,"")" ;FDA root -Check for existing entry
 .S @RAR@(.01)=RA01 ;Reason
 .S @RAR@(2)=RA2    ;Type of reason (1=cancel,3=hold,9=general)
 .S @RAR@(3)=RA3    ;Synonym
 .S @RAR@(4)="i"    ;Nature of order activity=Policy
 .S @RAR@(5)="Y"    ;NATIONAL flag = YES prevents local modifications
 .D UPDATE^DIE(,"RAFDA","","RAMSG(1)") K RAFDA
 .I $D(RAMSG(1,"DIERR"))#2 S RATXT="An error occured filing data for "_RA01
 .E  S RATXT=RA01_" filed"
 .D MES^XPDUTL(RATXT)  K RATXT,RAMSG
 Q
REA     ;REASON;SYNONYM;TYPE OF REASON
 ;;IMPORT REQUEST OBSOLETE BY POLICY;IMPORT OBSOLETE;1
 ;;IMPORT INSUFFICIENT JUSTIFICATION;JUSTIFICATION IMPORT;1
 ;;INCORRECT DESIRED DATE ENTERED;INC DD ENTERED;1
 ;;PER RADIOLOGIST - NOT CLINICALLY INDICATED;PER RAD NOT CLIN IND;1
 ;;PATIENT ALREADY SCREENED;PT ALREADY SCREENED;1
 ;;PER POLICY - RESCHED ATTEMPTS;PER POL R/S ATTEMPT;1
 ;;TEST PATIENT/ACCOUNT;TEST PT;1
 ;;PATIENT NOT PREPPED - RESCHEDULE;PT NOT PREP - R/S;3
 ;;REGISTERED IN ERROR - RESCHEDULE;REG ERROR - R/S;3
 ;;WALK IN - REGISTERED IN ERROR;WALK IN REG ERROR;3
