ORUA444P ;EPIP/RTW - QUICK ORDER POST INSTALL ; 4/26/17 12:54am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**444**;Dec 17, 1997;Build 48
 ;ICR#   Type  Description
 ;-----  ----  -------------------------------------
 ;2053   Sup   UPDATE^DIE
 D ADDGROUP,ORADDRPC
 Q
ADDGROUP ;
 N ORDISPGP,ORDGSQCE,ORMBNAME,ORMXNAME,ORSHNAME,ORDGIEN,ORDGIEN2,ORX,MSG,FDA2,FDA
 S ORDISPGP="" F ORDISPGP="DISCHARGE MEDS","PHARMACY UAP" Q:ORDISPGP=""  D
 . Q:$D(^ORD(100.98,"B",ORDISPGP))
 . S:ORDISPGP="DISCHARGE MEDS" ORSHNAME="DM",ORMXNAME="DISCHARGE MEDS"
 . S:ORDISPGP="PHARMACY UAP" ORSHNAME="UAP",ORMXNAME="UAP"
 . S FDA(100.98,"+1,",.01)=ORDISPGP
 . S FDA(100.98,"+1,",2)=ORMXNAME
 . S FDA(100.98,"+1,",3)=ORSHNAME
 . D UPDATE^DIE("","FDA","FDAIEN","MSG")
 . S ORDGIEN=+$P($Q(^ORD(100.98,"B",ORDISPGP)),",",4)
 . S ORDGSQCE=0,ORMBNAME="" S ORMBNAME="" F ORMBNAME="OUTPATIENT MEDICATIONS","INPATIENT MEDICATIONS","NON-VA MEDICATIONS" Q:ORMBNAME=""  Q:(ORDISPGP="DISCHARGE MEDS")&(ORDGSQCE=1)  D
 . . S ORDGIEN2=0,ORDGIEN2=$O(^ORD(100.98,"B",ORMBNAME,ORDGIEN2))
 . . S ORDGSQCE=ORDGSQCE+1
 . . S FDA2(1,100.981,"+2,"_ORDGIEN_",",.001)=ORDGSQCE
 . . S FDA2(1,100.981,"+2,"_ORDGIEN_",",.01)=ORDGIEN2
 . . D UPDATE^DIE("","FDA2(1)")
 . K FDA,FDAIEN
 I $D(MSG) D  Q
 . S ORX="Display Group Creation Failed.  The following error message was returned:"
 . W !
 . D MES^XPDUTL(ORX)
 S ORX="Display Groups created successfully."
 D MES^XPDUTL(ORX)
 Q
ORADDRPC ;ADD RPCS TO THE OR CPRS GUI CHART OPTION
 ;GET OR CPRS GUI CHART IEN
 ;ORTO GETRVW
 ;ORTO SET UAP FLAG
 ;ORTO SETRVW
 ;ORTO UAPOFF
 ;ORTO DGROUP
 N FDA,OROP,ORRPCIEN,ORTORPC
 S OROP=+$P($Q(^DIC(19,"B","OR CPRS GUI CHART")),",",4)
 S ORTORPC="" F ORTORPC="ORTO GETRVW","ORTO SET UAP FLAG","ORTO SETRVW","ORTO UAPOFF","ORTO DGROUP" Q:ORTORPC=""  D
 . S ORRPCIEN=0 S ORRPCIEN=$O(^XWB(8994,"B",ORTORPC,ORRPCIEN))
 . Q:$D(^DIC(19,OROP,"RPC","B",ORRPCIEN))
 . S FDA(1,19.05,"+2,"_OROP_",",.01)=ORRPCIEN
 . D UPDATE^DIE("","FDA(1)")
  Q
