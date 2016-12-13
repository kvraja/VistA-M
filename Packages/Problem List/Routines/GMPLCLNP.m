GMPLCLNP ;ISP/TC - Problem File Cleanup Routine ;01/14/16  13:41
 ;;2.0;Problem List;**40**;Aug 25, 1994;Build 9
 ;
 ;
 ; External References
 ;    ^%ZTLOAD              ICR  10063
 ;    MES^XPDUTL            ICR  10141
 ;    FILE^DIE              ICR   2053
 ;    UPDATE^DIE            ICR   2053
 ;    $$GET1^DIQ            ICR   2056
 ;    $$NOW^XLFDT           ICR  10103
 ;    $$FMTE^XLFDT          ICR  10103
 ;    $$SAB^ICDEX           ICR   5747
 ;    $$CODEC^ICDEX         ICR   5747
 ;    $$CODECS^ICDEX        ICR   5747
 ;    $$CODEN^ICDEX         ICR   5747
 ;    $$GETSYN^LEXTRAN1     ICR   5006
 ;
 ;
EN ; Main entry point to task off SCT error scan & cleanup
 ;
 N GMPLTEXT,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="SCANSCT^GMPLCLNP"
 S ZTDESC="Problem File SNOMED Error Scan and Cleanup"
 S ZTDTH=$H,ZTIO=""
 D ^%ZTLOAD
 S GMPLTEXT(1)=""
 S GMPLTEXT(2)=" Problem File SNOMED Error Scan and Cleanup queued."
 S GMPLTEXT(3)=" The task number is "_ZTSK_"."
 D MES^XPDUTL(.GMPLTEXT)
 Q
EN1 ; Main entry point to task off incorrect mapping scan & cleanup
 ;
 N GMPLTEXT,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 S ZTRTN="SCANVCDE^GMPLCLNP"
 S ZTDESC="Problem File Incorrect Mapping Scan and Cleanup"
 S ZTDTH=$H,ZTIO=""
 D ^%ZTLOAD
 S GMPLTEXT(1)=""
 S GMPLTEXT(2)=" Problem File Incorrect Mapping Scan and Cleanup queued."
 S GMPLTEXT(3)=" The task number is "_ZTSK_"."
 D MES^XPDUTL(.GMPLTEXT)
 Q
SCANSCT ; Scan Problem file for SCT in Diagnosis field errors
 N GMPLDIAG,GMPLDA,GMPLDLM,GMPLNERR,GMPLPROB,GMPLNARR,GMPLNIEN
 N GMPLPIEN,GMPLRNTM,GMPL0,GMPL1,GMPLSUB,GMPLFROM,GMPLMSG
 S (GMPLDIAG,GMPLDA,GMPLDLM)="",GMPLNERR=0
 K ^TMP("GMPLSCT",$J)
 S GMPLRNTM=$$NOW^XLFDT
 F  S GMPLDIAG=$O(^AUPNPROB("B",GMPLDIAG),-1) Q:GMPLDIAG=""  D
 . F  S GMPLDA=$O(^AUPNPROB("B",GMPLDIAG,GMPLDA),-1) Q:'GMPLDA  D
 . . I ($L(GMPLDIAG)>5),($L(GMPLDIAG)<19),($P($$CODEC^ICDEX(80,GMPLDIAG),U,1)=-1) D
 . . . S GMPL0=$G(^AUPNPROB(GMPLDA,0)),GMPL1=$G(^AUPNPROB(GMPLDA,1))
 . . . S GMPLDLM=$P(GMPL0,U,3)   ;Date Last Modified of erroneous record
 . . . S GMPLNIEN=$P(GMPL0,U,5)  ;IEN of Provider Narrative entry
 . . . S GMPLPROB=$$GET1^DIQ(9000011,""_GMPLDA_",",1.01,"E") ;Problem description
 . . . S GMPLNERR=GMPLNERR+1
 . . . S ^TMP("GMPLSCT",$J,GMPLDLM,GMPLDA)=$$FMTE^XLFDT(GMPLDLM,"1D")_U_GMPLDIAG_U_GMPLPROB_U_GMPLNIEN
 I GMPLNERR>0 D
 . D BLDERRPT^GMPLCLN(GMPLNERR,GMPLRNTM)
 . D BLDERMSG^GMPLCLN(GMPLNERR)
 . D CLNSCTE
 E  D
 . S GMPLSUB="Problem File Error Scan: No Errors Found"
 . S GMPLFROM="GMPL*2.0*40 INSTALL"
 . S GMPLMSG(1)="No errors were found that contain a SNOMED CT concept code in the"
 . S GMPLMSG(2)="Diagnosis field #.01."
 . D BLDNEMSG^GMPLCLN(.GMPLMSG,GMPLSUB,GMPLFROM,GMPLRNTM)
 Q
CLNSCTE ; Clean up erroneous PL entries in ^TMP("GMPLSCT")
 N GMPLDLM,GMPLDA,GMPLSCTC,GMPLSCTD,GMPLNARR,GMPLICD,GMPLNCLN,GMPLFDA,GMPLFROM
 N GMPLFDA1,GMPLREC,GMPLNIEN,GMPLPROB,GMPSYN,GMPLRNTM,GMPCNT,GMPLDIEN,GMPLIEN
 K ^TMP("GMPLCLNP",$J),^TMP("GMPLCLER",$J)
 S (GMPLDLM,GMPLDA)="",GMPLNCLN=0,GMPLRNTM=$$NOW^XLFDT,GMPCNT=0
 S GMPLFROM="GMPL*2.0*40 INSTALL"
 F  S GMPLDLM=$O(^TMP("GMPLSCT",$J,GMPLDLM)) Q:'GMPLDLM  D
 . F  S GMPLDA=$O(^TMP("GMPLSCT",$J,GMPLDLM,GMPLDA)) Q:'GMPLDA  D
 . . L +^AUPNPROB(GMPLDA):5 I '$T D  Q
 . . . S GMPCNT=GMPCNT+1
 . . . S ^TMP("GMPLCLER",$J,GMPCNT,0)="Error updating record #"_GMPLDA_" in File #9000011."
 . . . Q
 . . S GMPLREC=$G(^TMP("GMPLSCT",$J,GMPLDLM,GMPLDA))
 . . S GMPLSCTC=$P(GMPLREC,U,2),GMPLNIEN=$P(GMPLREC,U,4)
 . . S GMPLICD=$$GETDX^GMPLUTL(GMPLSCTC,GMPLDLM)
 . . S GMPLDIEN=$P($$CODEN^ICDEX($P(GMPLICD,"/"),80),"~",1)
 . . I $G(GMPLICD)["/" D FILEMT(GMPLDA,GMPLICD,GMPLDLM)
 . . I $P($$GETSYN^LEXTRAN1("SCT",GMPLSCTC,GMPLDLM,"GMPSYN",1,1),U)>0 D
 . . . S GMPLNARR=$P(GMPSYN("P"),U),GMPLPROB=$P(GMPSYN("P"),U,2),GMPLSCTD=$P(GMPSYN("P"),U,3)
 . . E  D
 . . . S GMPLNARR="Unresolved",GMPLPROB="1",GMPLSCTD="@"
 . . S GMPLIEN=""_GMPLDA_","
 . . S GMPLFDA(9000011,GMPLIEN,.01)=$S($G(GMPLICD)["/":$P(GMPLICD,"/"),1:$G(GMPLICD)) ; Primary Diagnosis (#.01)
 . . S GMPLFDA(9999999.27,""_GMPLNIEN_",",.01)=GMPLNARR ; Provider Narrative (#.05)
 . . S GMPLFDA1(9000011,GMPLIEN,1.01)=GMPLPROB ; Problem (#1.01)
 . . S GMPLFDA(9000011,GMPLIEN,80001)=GMPLSCTC ; SNOMED CT Concept code (#80001)
 . . S GMPLFDA(9000011,GMPLIEN,80002)=GMPLSCTD ; SNOMED CT Designation code (#80002)
 . . D FILE^DIE("E","GMPLFDA")
 . . D FILE^DIE("","GMPLFDA1")
 . . D CLNAUD(GMPLDLM,GMPLDA,GMPLDIEN)
 . . L -^AUPNPROB(GMPLDA)
 . . S GMPLNCLN=GMPLNCLN+1
 . . S ^TMP("GMPLCLNP",$J,GMPLDLM,GMPLDA)=$$FMTE^XLFDT(GMPLDLM,"1D")_U_GMPLICD_U_GMPLSCTC_U_GMPLSCTD_U_GMPLNARR
 K ^TMP("GMPLSCT",$J)
 I GMPCNT>0,$D(^TMP("GMPLCLER")) D
 . N GMPLMSG,GMPLNODE
 . S GMPLNODE="GMPLCLER"
 . S GMPLMSG(1)="Please run the Generate SNOMED in Diagnosis Field Err/Cleanup Rpt [GMPL"
 . S GMPLMSG(2)="GENERATE DIAG RPTS] menu option again to rerun the file scan and clean up"
 . S GMPLMSG(3)="these missed entries."
 . D BLDLEMSG^GMPLCLN(.GMPLMSG,GMPCNT,GMPLFROM,GMPLNODE)
 I GMPLNCLN>0 D
 . N GMPMSG,GMPSUB
 . S GMPSUB="SNOMED Error Cleanup Complete"
 . S GMPMSG(1)="These entries no longer contain a SNOMED CT concept code in the Diagnosis"
 . S GMPMSG(2)="field #.01. To see a report of these corrected records, please access the"
 . S GMPMSG(3)="SNOMED in Diagnosis Field Cleanup Report [GMPL DIAG CLEANUP REPORT] which is"
 . S GMPMSG(4)="attached to the Problem List Mgt Menu [GMPL MGT MENU]."
 . D BLDCLRPT^GMPLCLN(GMPLNCLN,GMPLRNTM)
 . D BLDCLMSG^GMPLCLN(.GMPMSG,GMPSUB,GMPLFROM,GMPLNCLN)
 Q
FILEMT(GMPDA,GMPICD,GMPDLM) ; File the associating Mapping Target codes
 N GMPN,GMPI,GMPCSYS,GMPNCNT,GMPFDA,GMPLFDA,GMPJ
 S GMPCSYS=$$SAB^ICDEX(+$$CODECS^ICDEX($P(GMPICD,"/"),80,GMPDLM),GMPDLM)
 ; Remove previous entries
 S GMPNCNT=+$P($G(^AUPNPROB(GMPDA,803,0)),U,4)
 I GMPNCNT>0 D
 . F GMPJ=1:1:GMPNCNT D
 . . S GMPLFDA(9000011.803,""_GMPJ_","_GMPDA_",",.01)="@"
 . . D FILE^DIE("","GMPLFDA")
 ; File new entries so that ACRMT xref is updated
 S GMPN=$L(GMPICD,"/")-1
 F GMPI=1:1:GMPN D
 . N GMPCODE,GMPNOS,GMPFDA,GMPDT S GMPNOS=$$NOS^GMPLX(GMPCSYS)
 . S GMPCODE=$P(GMPICD,"/",(GMPI+1)) Q:(GMPCODE="")
 . I GMPCODE=$P(GMPNOS,U,2) Q
 . S GMPDT=$$FMTE^XLFDT(GMPDLM,"1D")
 . S GMPFDA(9000011.803,"+2,"_GMPDA_",",.01)=GMPCODE
 . S GMPFDA(9000011.803,"+2,"_GMPDA_",",.02)=GMPCSYS
 . S GMPFDA(9000011.803,"+2,"_GMPDA_",",.03)=GMPDT
 . D UPDATE^DIE("E","GMPFDA")
 Q
CLNAUD(GMPLDLM,GMPLDA,GMPLDIEN) ; Cleanup audit history for Diagnosis field
 N GMPLAIEN,GMPLINVD,GMPLFLDN,GMPLNVAL,GMPQT,GMPL0
 S (GMPLINVD,GMPLAIEN)="",GMPQT=0,GMPLDA=GMPLDA-1
 F  S GMPLDA=$O(^GMPL(125.8,"AD",GMPLDA)) Q:'GMPLDA  D
 . F  S GMPLINVD=$O(^GMPL(125.8,"AD",GMPLDA,GMPLINVD)) Q:'GMPLINVD  D
 . . I $$CNVTFMDT(GMPLINVD)=GMPLDLM D
 . . . F  S GMPLAIEN=$O(^GMPL(125.8,"AD",GMPLDA,GMPLINVD,GMPLAIEN)) Q:'GMPLAIEN!GMPQT  D
 . . . . S GMPL0=$G(^GMPL(125.8,GMPLAIEN,0))
 . . . . S GMPLFLDN=$P(GMPL0,U,2),GMPLNVAL=$P(GMPL0,U,6)
 . . . . I (GMPLFLDN=".01"),($L(GMPLNVAL)>5),($L(GMPLNVAL)<19),($P($$CODEC^ICDEX(80,GMPLNVAL),U,1)=-1) D
 . . . . . N GMPFDA
 . . . . . S GMPFDA(125.8,""_GMPLAIEN_",",5)=GMPLDIEN,GMPQT=1
 . . . . . D FILE^DIE("K","GMPFDA")
 Q
CNVTFMDT(GMPLINVD) ; Convert an inverted date into FileMan format
 N GMPLFMDT
 S GMPLFMDT=9999999-GMPLINVD
 S GMPLFMDT=$P(GMPLFMDT,".")
 Q GMPLFMDT
SCANVCDE ; Scan Problem file for incorrect mapping (SCT 428283002, ICD-9 V15.89)
 N GMPLDA,GMPLNERR,GMPLNARR,GMPLSCTC,GMPLRNTM,GMPLPAT,GMPLICD,GMPL0,GMPLDIEN,GMPL1,GMPLPROV
 N GMPLSUB,GMPLFROM,GMPLMSG
 S GMPLDA="",GMPLNERR=0
 K ^TMP("GMPLVCDE",$J)
 S GMPLRNTM=$$NOW^XLFDT,GMPLSCTC="428283002"
 F  S GMPLDA=$O(^AUPNPROB("ASCT",GMPLSCTC,GMPLDA)) Q:'GMPLDA  D
 . S GMPL0=$G(^AUPNPROB(GMPLDA,0)),GMPL1=$G(^AUPNPROB(GMPLDA,1))
 . S GMPLDIEN=$P(GMPL0,U,1)
 . S GMPLICD=$$CODEC^ICDEX(80,GMPLDIEN) I $G(GMPLICD)="V15.89" D
 . . S GMPLPAT=$P($G(^DPT($P(GMPL0,U,2),0)),U)   ;Patient Name - ICR 10035
 . . S GMPLNARR=$$GET1^DIQ(9000011,""_GMPLDA_",",.05,"E")  ;Provider Narrative Text - ICR 1593
 . . S GMPLPROV=$P(GMPL1,U,4) ;Recording Provider
 . . S GMPLNERR=GMPLNERR+1
 . . S ^TMP("GMPLVCDE",$J,GMPLDA)=GMPLPAT_U_GMPLNARR_U_GMPLDIEN_U_GMPLPROV
 I GMPLNERR>0 D
 . D BLDRPMSG^GMPLCLN(GMPLNERR,GMPLRNTM)
 . D CLNVCDE
 E  D
 . S GMPLSUB="Incorrect Mapping Scan: No Errors Found"
 . S GMPLFROM="GMPL*2.0*40 INSTALL"
 . S GMPLMSG(1)="No incorrect SNOMED CT 428283002 to ICD-9-CM V15.89 code mappings"
 . S GMPLMSG(2)="for the term ""History of polyp of colon"" were found."
 . D BLDNEMSG^GMPLCLN(.GMPLMSG,GMPLSUB,GMPLFROM,GMPLRNTM)
 Q
CLNVCDE ; Clean up erroneous PL entries in ^TMP("GMPLVCDE")
 N GMPLDA,GMPLFDA,GMPCNT,GMPFDA,GMPLREC,GMPLPROV,GMPLDIEN,GMPLNCLN,GMPLFROM
 S GMPLDA="",GMPCNT=0,GMPLNCLN=0
 S GMPLFROM="GMPL*2.0*40 INSTALL"
 K ^TMP("GMPLLKER",$J)
 F  S GMPLDA=$O(^TMP("GMPLVCDE",$J,GMPLDA)) Q:'GMPLDA  D
 . L +^AUPNPROB(GMPLDA):5 I '$T D  Q
 . . S GMPCNT=GMPCNT+1
 . . S ^TMP("GMPLLKER",$J,GMPCNT,0)="Error updating record #"_GMPLDA_" in File #9000011."
 . . Q
 . S GMPLFDA(9000011,""_GMPLDA_",",.01)="V12.72"
 . D FILE^DIE("E","GMPLFDA")
 . L -^AUPNPROB(GMPLDA)
 . S GMPLNCLN=GMPLNCLN+1
 . ; Create audit history entry for modified Diagnosis field
 . S GMPLREC=$G(^TMP("GMPLVCDE",$J,GMPLDA))
 . S GMPLPROV=$P(GMPLREC,U,4),GMPLDIEN=$P(GMPLREC,U,3)
 . S GMPFDA(125.8,"+1,",.01)=GMPLDA
 . S GMPFDA(125.8,"+1,",1)=".01"
 . S GMPFDA(125.8,"+1,",2)=$$NOW^XLFDT
 . S GMPFDA(125.8,"+1,",3)=GMPLPROV
 . S GMPFDA(125.8,"+1,",4)=GMPLDIEN
 . S GMPFDA(125.8,"+1,",5)=$P($$CODEN^ICDEX("V12.72",80),"~")
 . S GMPFDA(125.8,"+1,",6)="DIAGNOSIS CORRECTION"
 . S GMPFDA(125.8,"+1,",7)=GMPLPROV
 . D UPDATE^DIE("","GMPFDA")
 K ^TMP("GMPLVCDE",$J)
 I GMPCNT>0,$D(^TMP("GMPLLKER")) D
 . N GMPLNODE S GMPLNODE="GMPLLKER"
 . D BLDLEMSG^GMPLCLN(,GMPCNT,GMPLFROM,GMPLNODE)
 I GMPLNCLN>0 D
 . N GMPMSG,GMPSUB
 . S GMPSUB="Incorrect Mapping Cleanup Complete"
 . S GMPMSG(1)="These entries no longer contain an incorrect mapping and a V15.89 code in the"
 . S GMPMSG(2)="Diagnosis field #.01. The correct code of V12.82 is now stored in this field."
 . D BLDCLMSG^GMPLCLN(.GMPMSG,GMPSUB,GMPLFROM,GMPLNCLN)
 Q
