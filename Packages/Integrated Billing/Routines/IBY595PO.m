IBY595PO ;EDE/DM - Post-Installation for IB patch 595 ; 01-APR-2018
 ;;2.0;INTEGRATED BILLING;**595**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
POST ; POST ROUTINE(S)
 N IBXPD,XPDIDTOT
 S XPDIDTOT=2
 ;
 ; Add new Source of Information
 D ADDSOI(1)
 ;
 ; Make sure the "AUTOUPDATE,IBEIV" PERSON exists
 D CHKAU(2)
 ;
 D MES^XPDUTL("")
 D MES^XPDUTL("POST-Install Completed.")
 Q
 ;
ADDSOI(IBXPD) ; Add new Source of Information.
 N IBLN,IBPCE,IBDATA,IBERR,IBIEN,IBSTR
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding new Source of Information Codes ... ")
 F IBLN=2:1 S IBSTR=$P($T(EN35512+IBLN),";;",2) Q:IBSTR=""  D
 . F IBPCE=1:1:3 S IBDATA(IBPCE/100)=$P(IBSTR,U,IBPCE)
 . I $D(^IBE(355.12,"C",IBDATA(.02))) D  Q
 .. D MES^XPDUTL("  "_IBDATA(.02)_" ALEADY EXISTS IN THE SOURCE OF INFORMATION TABLE (#355.12)") Q
 . S IBIEN=$$ADD^IBDFDBS(355.12,,.IBDATA,.IBERR)
 . I IBERR D  Q
 .. D BMES^XPDUTL("*** ERROR ADDING "_IBDATA(.02)_" CODE TO THE SOURCE OF INFORMATION TABLE (#355.12) ***")
 . D BMES^XPDUTL("  "_$$GET1^DIQ(355.12,IBIEN_",",.02)_" CODE ADDED TO THE SOURCE OF INFORMATION TABLE (#355.12)")
 D MES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT_" COMPLETE")
 Q
 ;
CHKAU(IBXPD) ; Make sure the "AUTOUPDATE,IBEIV" PERSON exists in #200
 N IEN200,IBAUNAME
 S IBAUNAME="AUTOUPDATE,IBEIV"
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Checking for "_IBAUNAME_" in the New Person file (#200) ... ")
 ; Supported by IA#4677.
 S IEN200=$$CREATE^XUSAP(IBAUNAME,"")
 I +IEN200=0 D MES^XPDUTL("  "_IBAUNAME_" exists.")
 I +IEN200>0 D MES^XPDUTL("  "_IBAUNAME_" added.")
 I IEN200<0 D MES^XPDUTL("*(ERROR) "_IBAUNAME_" NOT added.")
 D MES^XPDUTL("STEP "_IBXPD_" of "_XPDIDTOT_" COMPLETE")
 Q
 ;
EN35512  ; Add Source of Information Codes
 ;
 ;;20^MYVA HEALTH JOURNAL^MVAH
