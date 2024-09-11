SDES884P ;ALB/MGD - SD*5.3*884 Post Init Routine ; Jun 07, 2024
 ;;5.3;SCHEDULING;**884**;AUG 13, 1993;Build 1
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to WEB SERVER (#18.12) IN ICR #6171
 ; Reference to PARAMETER DEFINITION (#8989.51) IN ICR #3985
 Q
 ;
EN ;
 D VSS
 Q
 ;
 ;
VSS ; Execute post install logic to add needed file entries for VVS interface
 N FDA,SDCNTXTRT,SDSRVC,SDSTA3N,DESCRIPTION,PPARAMDEFIEN,TPARAMDEFIEN,WEBSERVMULT
 ;
 ; ==========
 ; Add Production WEB SERVICE entry
 D BMES^XPDUTL(">> Updating WEB SERVICE (#18.02) file...")
 S SDSRVC="SD VVS WEB SERVICE"
 S SDCNTXTRT="/vvs/v3/vista/appointments/cancellations/"
 D REGREST^XOBWLIB(SDSRVC,SDCNTXTRT) ; REGREST^XOBWLIB handles all messaging.
 ;
 ; Add Test WEB SERVICE entry
 S SDSRVC="SD VVS WEB SERVICE TEST"
 S SDCNTXTRT="/vvs/v3/vista/appointments/cancellations/"
 D REGREST^XOBWLIB(SDSRVC,SDCNTXTRT) ; REGREST^XOBWLIB handles all messaging.
 ;
 ; ==========
 ; Add Production WEB SERVER entry
 D BMES^XPDUTL(">> Updating WEB SERVER (#18.12) file...")
 S SDSTA3N=+$$STA^XUAF4($$KSP^XUPARAM("INST"))
 K FDA,NEWIEN,MSGROOT
 S FDA(18.12,"?+1,",.01)="SD VVS WEB SERVER"       ; NAME
 S FDA(18.12,"?+1,",.04)="staff.mobile.domain.ext"     ; SERVER
 S FDA(18.12,"?+1,",.06)="ENABLED"                 ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,"?+1,",.07)=10                        ; DEFAULT HTTP TIMEOUT - time is seconds
 S FDA(18.12,"?+1,",3.01)="TRUE"                   ; SSL ENABLED
 S FDA(18.12,"?+1,",3.02)="encrypt_only_tlsv12"    ; SSL CONFIGURATION
 S FDA(18.12,"?+1,",3.03)=443                      ; SSL PORT
 ;
 D UPDATE^DIE("E","FDA","NEWIEN","MSGROOT")
 I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 I '$D(MSGROOT("DIERR")) D
 . K FDA
 . S WEBSERVMULT=NEWIEN(1)
 . S FDA(18.121,"?+1,"_WEBSERVMULT_",",.01)="SD VVS WEB SERVICE"
 . S FDA(18.121,"?+1,"_WEBSERVMULT_",",.06)="ENABLED"
 . D UPDATE^DIE("E","FDA","NEWIEN","MSGROOT")
 . I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 . I '$D(MSGROOT("DIERR")) D BMES^XPDUTL("  SD VVS WEB SERVER successfully filed for station "_SDSTA3N)
 ;
 ; Add Test WEB SERVER entry
 K FDA,NEWIEN,MSGROOT
 S FDA(18.12,"?+1,",.01)="SD VVS WEB SERVER TEST"       ; NAME
 S FDA(18.12,"?+1,",.04)="staff.apps-staging.domain.ext"    ; SERVER
 S FDA(18.12,"?+1,",.06)="ENABLED"                      ; STATUS 1-ENABLED / 0-DISABLED
 S FDA(18.12,"?+1,",.07)=10                             ; DEFAULT HTTP TIMEOUT - time is seconds
 S FDA(18.12,"?+1,",3.01)="TRUE"                        ; SSL ENABLED
 S FDA(18.12,"?+1,",3.02)="encrypt_only_tlsv12"         ; SSL CONFIGURATION
 S FDA(18.12,"?+1,",3.03)=443                           ; SSL PORT
 ;
 D UPDATE^DIE("E","FDA","NEWIEN","MSGROOT")
 I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 I '$D(MSGROOT("DIERR")) D
 . K FDA
 . S WEBSERVMULT=NEWIEN(1)
 . S FDA(18.121,"?+1,"_WEBSERVMULT_",",.01)="SD VVS WEB SERVICE TEST"
 . S FDA(18.121,"?+1,"_WEBSERVMULT_",",.06)="ENABLED"
 . D UPDATE^DIE("E","FDA","NEWIEN","MSGROOT")
 . I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 . I '$D(MSGROOT("DIERR")) D BMES^XPDUTL("  SD VVS WEB SERVER TEST successfully filed for station "_SDSTA3N)
 ;
 ; ==========
 ; Add Production entry to PARAMETER (#8989.5) file
 D BMES^XPDUTL(">> Updating PARAMETER (#8989.5) file...")
 N ENTITY,PARAMETER,INSTANCE,SDKEY
 S ENTITY="PKG.SCHEDULING"
 S PARAMETER="SD-VVS-CANCEL-KEY"
 S INSTANCE=1
 S SDKEY=$$B64ENCD^XUSHSH($$AESENCR^XUSHSH("0e537e16-c42d-4897-aa73-2d5edffc0a30","3ncr4pt55SK3y"))
 D ADD^XPAR(ENTITY,PARAMETER,INSTANCE,SDKEY,"MSGROOT")
 I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 I '$D(MSGROOT("DIERR")) D BMES^XPDUTL("  SD-VVS-CANCEL-KEY successfully filed for station "_SDSTA3N)
 ;
 ; Reset Production PROHIBIT EDITING to Yes
 K FDA,NEWIEN,MSGROOT
 S PPARAMDEFIEN=$$FIND1^DIC(8989.51,"","X","SD-VVS-CANCEL-KEY")
 I PPARAMDEFIEN D
 . S FDA(8989.51,PPARAMDEFIEN_",",.06)="Yes"  ; PROHIBIT EDITING - 1:Yes
 . D UPDATE^DIE("E","FDA","NEWIEN","MSGROOT")
 . I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 . I '$D(MSGROOT("DIERR")) D BMES^XPDUTL("  SD-VVS-CANCEL-KEY set to No Editing for station "_SDSTA3N)
 ;
 ; ==========
 ; Add Test entry to PARAMETERS (#8989.5) file
 S ENTITY="PKG.SCHEDULING"
 S PARAMETER="SD-VVS-CANCEL-KEY-TEST"
 S INSTANCE=1
 S SDKEY=$$B64ENCD^XUSHSH($$AESENCR^XUSHSH("ab6373ef-749f-42b5-8920-2ee809140724","3ncr4pt55SK3y"))
 D ADD^XPAR(ENTITY,PARAMETER,INSTANCE,SDKEY,"MSGROOT")
 I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 I '$D(MSGROOT("DIERR")) D BMES^XPDUTL("  SD-VVS-CANCEL-KEY-TEST successfully filed for station "_SDSTA3N)
 ;
 ; Reset Test PROHIBIT EDITING to Yes
 K FDA,NEWIEN,MSGROOT
 S TPARAMDEFIEN=$$FIND1^DIC(8989.51,"","X","SD-VVS-CANCEL-KEY-TEST")
 I TPARAMDEFIEN D
 . S FDA(8989.51,TPARAMDEFIEN_",",.06)="Yes"  ; PROHIBIT EDITING - 1:Yes
 . D UPDATE^DIE("E","FDA","NEWIEN","MSGROOT")
 . I $D(MSGROOT("DIERR")) D BMES^XPDUTL($G(MSGROOT("DIERR",1,"TEXT",1)))
 . I '$D(MSGROOT("DIERR")) D BMES^XPDUTL("  SD-VVS-CANCEL-KEY-TEST set to No Editing for station "_SDSTA3N)
 Q
