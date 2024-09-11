PSOERXU3 ;ALB/BWF - eRx utilities ; 5/26/2017 9:57am
 ;;7.0;OUTPATIENT PHARMACY;**508,591,606,581,617,646,700,746**;DEC 1997;Build 106
 ;
 Q
 ; PSO*508 - Added MEDDIS, RRREQ, and RRRES linetags.
 ; ERXIEN - IEN FROM 52.49
 ; DTYPE - R for REQUESTED, or D for dispensed drugs
MEDDIS(ERXIEN,DTYPE,LINE) ;
 N DRUG,DIEN,QTY,DAYS,WDATE,EFDATE,REFILL,EXDATE,LFDATE,DIRECT,CLQ,USC,PUC,F,IENS,I,LTXT
 N RXIEN,RXNUM,INS,DDAT,PARIEN,OREFILL,DLOOP,DIRARY,MTYPE,QUOM
 S F=52.4949
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"****************************MEDICATION DISPENSED****************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                              MEDICATION DISPENSED                              "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 S PARIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I PARIEN S RXIEN=$$GET1^DIQ(52.49,PARIEN,.13,"I")
 I PARIEN S QUOM=$$GET1^DIQ(52.49,PARIEN,5.4,"E")
 I $E($G(QUOM))="C" S QUOM=$$CODERES^PSOERXU7(QUOM,"NCI")
 I $G(RXIEN) S OREFILL=$$GET1^DIQ(52,RXIEN,9,"E")
 S I=0 F  S I=$O(^PS(52.49,ERXIEN,49,I)) Q:'I  D
 .S IENS=I_","_ERXIEN_","
 .;Q:$$GET1^DIQ(F,IENS,.02,"I")'=DTYPE
 .D GETS^DIQ(F,IENS,"**","IE","DDAT")
 .S DRUG=$G(DDAT(F,IENS,.01,"E"))
 .S DIEN=$G(DDAT(F,IENS,.03,"I"))
 .S QTY=$G(DDAT(F,IENS,.04,"E"))
 .S DAYS=$G(DDAT(F,IENS,.05,"E"))
 .S REFILL=$G(DDAT(F,IENS,.06,"E"))
 .S DIRECT=$G(DDAT(F,IENS,1,"E"))
 .S WDATE=$G(DDAT(F,IENS,2.1,"E"))
 .S LFDATE=$G(DDAT(F,IENS,2.2,"E"))
 .S EXDATE=$G(DDAT(F,IENS,2.3,"E"))
 .S EFDATE=$G(DDAT(F,IENS,2.4,"E"))
 .S CLQ=$G(DDAT(F,IENS,2.5,"E"))
 .S USC=$G(DDAT(F,IENS,2.6,"E"))
 .S PUC=$G(DDAT(F,IENS,2.7,"E"))
 .; if there is an RX ien, reset the refills to that value - may need to adjust other fields as well
 .I $G(RXIEN) S REFILL=$$GET1^DIQ(52,RXIEN,9,"E")
 .S LINE=LINE+1 D SET^VALM10(LINE,"Vista Drug: "_DRUG_" "_$P($$VADRSCH^PSOERXUT(+$G(DIEN)),"^",3)),CNTRL^VALM10(LINE,13,68,$G(IOINHI),$G(IOINORM))
 .S LINE=LINE+1
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Qty: ",$G(QTY),1,25)
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Refills: ",$G(REFILL),27,18)
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Days Supply: ",$G(DAYS),54,22)
 .D SET^VALM10(LINE,LTXT)
 .D CNTRL^VALM10(LINE,12,10,$G(IOINHI),$G(IOINORM)) ;Vista Qty
 .D CNTRL^VALM10(LINE,43,10,$G(IOINHI),$G(IOINORM)) ;Vista Refills
 .D CNTRL^VALM10(LINE,74,7,$G(IOINHI),$G(IOINORM)) ;Vista Days Supply
 .S LTXT=""
 .S LINE=LINE+1 D SET^VALM10(LINE,"Quantity Unit of Measure: "_$G(QUOM)),CNTRL^VALM10(LINE,27,$L($G(QUOM)),$G(IOINHI),$G(IOINORM)) ;Vista Days Supply
 .S DIRECT="Vista Sig: "_DIRECT
 .D TXT2ARY^PSOERXD1(.DIRARY,DIRECT," ",75)
 .S DLOOP=0 F  S DLOOP=$O(DIRARY(DLOOP)) Q:'DLOOP  D
 ..S LINE=LINE+1
 ..D SET^VALM10(LINE,$G(DIRARY(DLOOP)))
 ..I DLOOP=1 D CNTRL^VALM10(LINE,12,$L($P($G(DIRARY(DLOOP)),":",2)),$G(IOINHI),$G(IOINORM)) Q
 ..D CNTRL^VALM10(LINE,1,$L($G(DIRARY(DLOOP))),$G(IOINHI),$G(IOINORM))
 I $G(RXIEN) D
 .S RXNUM=$$GET1^DIQ(52,RXIEN,.01,"E")
 .S INS=0 F  S INS=$O(^PSRX(RXIEN,"INS1",INS)) Q:'INS  D
 ..S LINE=LINE+1 D SET^VALM10(LINE,"Pat Inst: "_$$GET1^DIQ(52.0115,INS_","_RXIEN_",",.01,"E")),CNTRL^VALM10(LINE,11,69,$G(IOINHI),$G(IOINORM))
 I '$L($G(RXNUM)) S RXNUM="Unable to resolve."
 S LINE=LINE+1 D SET^VALM10(LINE,"VA Rx#: "_$G(RXNUM)),CNTRL^VALM10(LINE,9,$L($G(RXNUM)),$G(IOINHI),$G(IOINORM))
 Q
 ; refill request information
RRREQ(ERXIEN,LINE) ;
 D RRREQ^PSOERXU7(ERXIEN,.LINE)
 Q
 ;
MSGHIS(ERXIEN,LINE) ;
 D MSGHIS^PSOERXU7(ERXIEN,.LINE)
 Q
 ; refill response information
RRRES(ERXIEN,LINE,PMODE) ;p646 added PMODE parameter. 
 ; If PMODE is greater than 0 then the video control calls will be utilized.
 N RESVAL,RESNOTE,I,RESCODE,RESDTTM,RESDESC,ERXDAT,IENS,RESIEN,RECODE,RESTEXT,MTYPE,REQIEN,CODEIEN,RESDESCARY
 N STR1ARY,STR2ARY,J,STR1,STR2,DELTA,FN,COMM,COMMARY,COMMBY,COMMDTTM,ERESCODE,S2017,REQS2017,RESS2017,II,NOTEARY
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I MTYPE="RE"!(MTYPE="CN") S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I MTYPE="RR"!(MTYPE="CA") S REQIEN=ERXIEN,RESIEN=$$GETRESP^PSOERXU2(ERXIEN) Q:'RESIEN
 S REQS2017=$$GET1^DIQ(52.49,REQIEN,312.1)
 S RESS2017=$$GET1^DIQ(52.49,RESIEN,312.1)
 S IENS=RESIEN_","
 D GETS^DIQ(52.49,RESIEN,".03;.13;52.1;52.2;52.3","IE","ERXDAT")
 S RESVAL=$G(ERXDAT(52.49,IENS,52.1,"E"))
 S RESCODE=$G(ERXDAT(52.49,IENS,52.1,"I"))
 S RESNOTE=$G(ERXDAT(52.49,IENS,52.2,"E"))
 S RESDTTM=$G(ERXDAT(52.49,IENS,.03,"E"))
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"************************RXRENEWAL RESPONSE INFORMATION**************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                         RXRENEWAL RESPONSE INFORMATION                         "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,RESVAL) D:$G(PMODE) CNTRL^VALM10(LINE,1,$L(RESVAL),$G(IORVON),$G(IORVOFF))
 S LINE=LINE+1 D SET^VALM10(LINE,"Response Date/Time: "_RESDTTM),CNTRL^VALM10(LINE,21,$L(RESDTTM),$G(IOINHI),$G(IOINORM))
 D TXT2ARY^PSOERXD1(.NOTEARY,RESNOTE," ",75)
 S II=0 F  S II=$O(NOTEARY(II)) Q:'II  D
 . S LINE=LINE+1 D SET^VALM10(LINE,$S(II=1:"Note: ",1:$J("",6))_NOTEARY(II)),CNTRL^VALM10(LINE,7,$L(RESNOTE),$G(IOINHI),$G(IOINORM))
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S COMM=$$GET1^DIQ(52.49,RESIEN,50,"E")
 S COMM="RxRenewal Response Comments: "_COMM
 D TXT2ARY^PSOERXD1(.COMMARY,COMM," ",80)
 S I=0 F  S I=$O(COMMARY(I)) Q:'I  D
 .S CTXT=$G(COMMARY(I))
 .S LINE=LINE+1 D SET^VALM10(LINE,CTXT)
 . I I=1 D CNTRL^VALM10(LINE,30,$L($P(CTXT,":",2)),$G(IOINHI),$G(IOINORM)) Q
 . D CNTRL^VALM10(LINE,1,$L(CTXT),$G(IOINHI),$G(IOINORM))
 S COMMBY=$$GET1^DIQ(52.49,RESIEN,50.1,"E")
 S COMMDTTM=$$GET1^DIQ(52.49,RESIEN,50.2,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments By: "_COMMBY),CNTRL^VALM10(LINE,14,$L(COMMBY),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments Date/Time: "_COMMDTTM),CNTRL^VALM10(LINE,21,$L(COMMDTTM),$G(IOINHI),$G(IOINORM))
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S I=0 F  S I=$O(^PS(52.49,RESIEN,55,I)) Q:'I  D 
 .S ERESCODE=$$GET1^DIQ(52.4955,I_","_IENS,.01,"E")
 .S CODEIEN=$$GET1^DIQ(52.4955,I_","_IENS,.01,"I")
 .S RESDESC=$$GET1^DIQ(52.45,CODEIEN,.02,"E")
 .S RESTEXT=RESVAL_" reason code: "_ERESCODE
 .S LINE=LINE+1 D SET^VALM10(LINE,RESTEXT) D:$G(PMODE) CNTRL^VALM10(LINE,1,$L(RESTEXT),$G(IORVON),$G(IORVOFF))
 .S LINE=LINE+1 D SET^VALM10(LINE,"Code Description: "_RESDESC)
 .D TXT2ARY^PSOERXD1(.RESDESCARY,RESDESC," ",80)
 .S II=0 F  S II=$O(RESDESCARY(II)) Q:'II  D
 ..S CTXT=$G(RESDESCARY(II))
 ..S LINE=LINE+1 D SET^VALM10(LINE,CTXT)
 ..I II=1 D CNTRL^VALM10(LINE,19,$L($P(CTXT,":",2)),$G(IOINHI),$G(IOINORM)) Q
 ..D CNTRL^VALM10(LINE,1,$L(CTXT),$G(IOINHI),$G(IOINORM))
 I '$G(REQS2017),'$G(RESS2017) D
 .I RESCODE="AWC"!(RESCODE="A") D
 ..D RRDELTA^PSOERXU2(.DELTA,REQIEN,RESIEN) Q:'$D(DELTA)
 ..S LINE=LINE+1
 ..I $G(SDERXFLG) D SET^VALM10(LINE,"                                CHANGED ITEMS                                   "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 ..E  D SET^VALM10(LINE,"********************************CHANGED ITEMS***********************************")
 ..S I=0 F  S I=$O(DELTA(I)) Q:'I  D
 ...S FN="" F  S FN=$O(DELTA(I,FN)) Q:FN=""  D
 ....K STR1ARY,STR2ARY
 ....S LINE=LINE+1 D SET^VALM10(LINE,"Field: "_FN) D:$G(PMODE) CNTRL^VALM10(LINE,1,$L(FN)+7,$G(IORVON),$G(IORVOFF))
 ....S STR1="RxRenewal Request Value  : "_$P(DELTA(I,FN),U)
 ....D TXT2ARY^PSOERXD1(.STR1ARY,STR1," ",78)
 ....S STR2="RxRenewal Response Value : "_$P(DELTA(I,FN),U,2)
 ....D TXT2ARY^PSOERXD1(.STR2ARY,STR2," ",78)
 ....S J=0 F  S J=$O(STR1ARY(J)) Q:'J  D
 .....S LINE=LINE+1 D SET^VALM10(LINE,"  "_$G(STR1ARY(J))),CNTRL^VALM10(LINE,28,$L($G(STR1ARY(J))),$G(IORVON),$G(IORVOFF))
 ....S J=0 F  S J=$O(STR2ARY(J)) Q:'J  D
 .....S LINE=LINE+1 D SET^VALM10(LINE,"  "_$G(STR2ARY(J))),CNTRL^VALM10(LINE,28,$L($G(STR2ARY(J))),$G(IORVON),$G(IORVOFF))
 ....I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 Q
ERRDISP(ERXIEN,LINE) ;
 D ERRDISP^PSOERXU7(ERXIEN,.LINE)
 Q
 ; displays processing errors
PROCERR(ERXIEN,LINE) ;
 D PROCERR^PSOERXU7(ERXIEN,.LINE)
 Q
 ;
 ; automatically DC a prescription if a denied, new prescription to follow is recieved
AUTODC(ERXIEN) ;
 N PSODFN,RXIEN,PSOLST,ORN,PSOOPT,PSOSITE,PSODIV,PSOSYS,PSODIV,PSOSYS,NERXIEN
 N RTYPE,REQIEN,ERRSEQ,VALMSG,ERXIENS,RXSTAT,PSTAT,MTYPE
 Q:'ERXIEN
 S ERXIENS=ERXIEN_","
 ; get the RXIEN
 S REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I REQIEN S NERXIEN=$$RESOLV^PSOERXU2(REQIEN)
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S RTYPE=$$GET1^DIQ(52.49,ERXIEN,52.1,"I")
 ; if for some reason the newrx could not be identified, there is no way we can auto-dc, so quit
 Q:'$P($G(NERXIEN),U)
 S RXIEN=$$GET1^DIQ(52.49,NERXIEN,.13,"I") Q:RXIEN=""
 ; if already DC'd, do not try to DC again
 S RXSTAT=$$GET1^DIQ(52,RXIEN,100,"I")
 I (RXSTAT=12)!(RXSTAT=14)!(RXSTAT=15) D  Q
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .S VALMSG="eRx auto-discontinue failed. Prescription is already discontinued."
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 .I MTYPE="CX" D  Q
 ..D UPDSTAT^PSOERXU1(ERXIEN,"CXE",$G(VALMSG))
 ..I REQIEN,$$GET1^DIQ(52.49,REQIEN,1,"E")'="CRR" D UPDSTAT^PSOERXU1(REQIEN,"CRR",$G(VALMSG))
 .I REQIEN,$$GET1^DIQ(52.49,REQIEN,1,"E")'="RRR" D UPDSTAT^PSOERXU1(REQIEN,"RRR",$G(VALMSG))
 .I RTYPE="R" D UPDSTAT^PSOERXU1(ERXIEN,"RXE",$G(VALMSG)) Q
 .D UPDSTAT^PSOERXU1(ERXIEN,"RXF",$G(VALMSG))
 S PSOSITE=$$GET1^DIQ(52,RXIEN,20,"I")
 S PSOSYS=$G(^PS(59.7,1,40.1)) Q:PSOSYS=""
 S PSODFN=$$GET1^DIQ(52,RXIEN,2,"I") Q:'PSODFN
 S PSOLST(1)=52_U_RXIEN_U_$$GET1^DIQ(52,RXIEN,100,"E")
 S ORN=1
 S PSOOPT=0
 D OERR^PSOCAN3(NERXIEN)
 S PSTAT=$$GET1^DIQ(52,RXIEN,100,"I")
 I PSTAT<12!(PSTAT>15) D  Q
 .I '$L($G(VALMSG)) S VALMSG="eRx auto-discontinue failed."
 .I RTYPE="R" D UPDSTAT^PSOERXU1(ERXIEN,"RXE",$G(VALMSG))
 .I RTYPE'="R" D UPDSTAT^PSOERXU1(ERXIEN,"RXF",$G(VALMSG))
 .I MTYPE="RE",REQIEN,$$GET1^DIQ(52.49,REQIEN,.08,"I")'="RRR" D UPDSTAT^PSOERXU1(REQIEN,"RRR",$G(VALMSG))
 .S ERRSEQ=$$ERRSEQ^PSOERXU1(ERXIEN) Q:'ERRSEQ
 .D FILERR^PSOERXU1(ERXIENS,ERRSEQ,"PX","V",$G(VALMSG))
 .I MTYPE="CX" D  Q
 ..D UPDSTAT^PSOERXU1(ERXIEN,"CXE",$G(VALMSG))
 ..I REQIEN,$$GET1^DIQ(52.49,REQIEN,1,"E")'="CRR" D UPDSTAT^PSOERXU1(REQIEN,"CRR",$G(VALMSG))
 I MTYPE="CX",(RTYPE="A"!(RTYPE="AWC")!(RTYPE="V")) D  Q
 .D UPDSTAT^PSOERXU1(NERXIEN,"CXQ")
 .I $$GET1^DIQ(52.49,REQIEN,1,"E")'="CRR" D UPDSTAT^PSOERXU1(REQIEN,"CRR")
 I MTYPE="RE",RTYPE="R" D  Q
 .D UPDSTAT^PSOERXU1(ERXIEN,"RXR")
 .I REQIEN D UPDSTAT^PSOERXU1(REQIEN,"RRR")
 D UPDSTAT^PSOERXU1(ERXIEN,"RXD")
 I REQIEN,$$GET1^DIQ(52.49,REQIEN,.08,"I")="RR" D UPDSTAT^PSOERXU1(REQIEN,"RRP")
 Q
 ; screen out options that do not apply to refill request or refill response
RRRESCR(ERXIEN,OPT) ;
 N MTYPE,REFREQ,REFRES,OK,DELTAS,RESTYPE,ERXSTAT,MESREQ
 S OK=1
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S RESTYPE=$$GET1^DIQ(52.49,ERXIEN,52.1,"I")
 S MESREQ=$$GET1^DIQ(52.49,ERXIEN,315.1,"I")
 S ERXSTAT=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 I MTYPE="CX" D  Q OK
 .I $E(RESTYPE)="V" S OK=1 Q
 .I $E(RESTYPE)'="A",",G,T,S,OS,D,"'[MESREQ S OK=0
 I MTYPE="RR"!(MTYPE="CA")!(MTYPE="CN") S OK=0 Q OK
 ; if this is a refill response, and we are screening the provider action
 I MTYPE="RE" D  Q OK
 .; THESE 3 LINES ARE FOR REPLACE TYPE RENEWAL REQUEST UNLOCKS ON VALIDATION ACTIONS
 .I '$D(OPT),RESTYPE="R" S OK=1 Q
 .I '$D(OPT) S OK=0 Q
 .I OPT="ACCEPT",RESTYPE="R",ERXSTAT="RXW"!(ERXSTAT="RXI") S OK=1 Q
 .I OPT="PROVIDER",RESTYPE="R","RXP,RXC"'[ERXSTAT S OK=1 Q
 .I OPT="DRUG",RESTYPE="R","RXP,RXC"'[ERXSTAT S OK=1 Q
 .I '$D(OPT) S OK=0 Q
 .I $$GET1^DIQ(52.49,ERXIEN,52.1,"I")["D" S OK=0 Q
 .I "RXP,RXC,RXF,RXE"[$$GET1^DIQ(52.49,ERXIEN,1,"E") S OK=0 Q
 .S REFRES=ERXIEN,REFREQ=$$RESOLV^PSOERXU2(ERXIEN)
 .I 'REFREQ!('REFRES) S OK=0 Q
 .D RRDELTA^PSOERXU2(.DELTAS,REFREQ,REFRES)
 .I OPT="PROVIDER",$D(DELTAS(52.49,"EXTERNAL PROVIDER")),'$$GET1^DIQ(52.49,ERXIEN,.13,"I") S OK=1
 .; if there were changes to the provider, user will need to revalidate and accept
 .; only unlock if there were deltas on the provider and the provider has been validated on this message
 .I OPT="ACCEPT",'$D(DELTAS(52.49,"EXTERNAL PROVIDER")) S OK=0 Q
 .I OPT="ACCEPT",$D(DELTAS(52.49,"EXTERNAL PROVIDER")),$$GET1^DIQ(52.49,ERXIEN,1.3,"I"),'$$GET1^DIQ(52.49,ERXIEN,.13,"I") S OK=1
 .; if changes are in the drug segment only, no validations or other pharmacist actions needed
 .I OPT="DRUG" S OK=0
 I MTYPE="RE",OPT="DRUG" S OK=0 Q OK
 Q OK
 ;
 ;Process refill response into pending outpatient orders
PREFRES(PSOIEN,PSOHY,PSOEXCNT,PSOEXMS,PSODAT) ;
 N REQIEN,ORXIEN,PROVIEN,VADRG,PRMVAL,DMVAL,PMVAL,RXIEN,RESTYPE,DELTA,PSOIENS
 S PSOIENS=PSOIEN_","
 S RESTYPE=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 S REQIEN=$$RESOLV^PSOERXU2(PSOIEN) I REQIEN S ORXIEN=$$RESOLV^PSOERXU2(REQIEN)
 I '$G(ORXIEN) S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Could not resolve original eRx. Cannot process response." Q
 S RXIEN=$$GET1^DIQ(52.49,ORXIEN,.13,"I") I 'RXIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Could not resolve original eRx. Cannot process response." Q
 I RESTYPE="A" D PSOHY(.PSOHY,PSOIEN,ORXIEN,RXIEN) Q
 ; process 'approved with changes' response types
 ; if this refill response has any validations/linkages, use them. Otherwise, use the validations/linkages from the original (new) rx.
 D RRDELTA^PSOERXU2(.DELTA,REQIEN,PSOIEN)
 S PROVIEN=""
 I $D(DELTA(52.49,"EXTERNAL PROVIDER")) D
 .S PROVIEN=$G(PSODAT(F,PSOIENS,2.3,"I")) ; response message provider IEN
 .I 'PROVIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Provider not linked. Cannot process renewal request." Q
 .; if the provider or drug has been linked, then a change has occured in one of those segments, so they must be validated
 .S PRMVAL=$G(PSODAT(F,PSOIENS,1.3,"I")) I 'PRMVAL S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Provider not validated. Cannot process renewal request." Q
 Q:$O(PSOEXMS(0))
 D PSOHY(.PSOHY,PSOIEN,ORXIEN,RXIEN,PROVIEN) Q
 Q
 ; ERXIEN - refill response IEN from 52.49
 ; ORXIEN - newRx IEN from 52.49
 ; RXIEN - prescription entry from file #52
 ; PROVOVR - provider override, when approved with changes included a change to the provider
PSOHY(PSOHY,ERXIEN,ORXIEN,RXIEN,PROVOVR) ;
 N RXDAT,ERXRFLS,ERXWDATE,LOC,ERXNUM,RXIENS,VAROUT,PROVIEN,EFFDT,VAOI,VADRUG,VAREF,PATIEN,VAPRIOR,ORDERTYP,VADAYS,VQTY
 N WRITDT,SLOOP,SCNT,SLOOP2
 S RXIENS=RXIEN_","
 S ERXNUM=$$GET1^DIQ(52.49,ERXIEN,.01,"E")
 D GETS^DIQ(52,RXIEN,"**","IE","RXDAT")
 S LOC=$G(RXDAT(52,RXIENS,5,"I"))
 S VAROUT=$G(RXDAT(52,RXIENS,11,"I"))
 S PROVIEN=$S($G(PROVOVR):PROVOVR,1:$G(RXDAT(52,RXIENS,4,"I")))
 ; effective date CANNOT be null.. make sure it is set to something. written date is the first fall back, then todays date
 S EFFDT=$$GET1^DIQ(52.49,ERXIEN,6.3,"I") I 'EFFDT S EFFDT=$$GET1^DIQ(52.49,ERXIEN,5.9,"I")
 I 'EFFDT S EFFDT=DT
 S VAOI=$G(RXDAT(52,RXIENS,39.2,"I"))
 S VQTY=$G(RXDAT(52,RXIENS,7,"E"))
 S VADRUG=$G(RXDAT(52,RXIENS,6,"I"))
 ; always decrement 1 from # of refills, because refills is actually total # of fills.
 S VAREF=$$GET1^DIQ(52.49,ERXIEN,5.6,"E")
 I VAREF>0 S VAREF=VAREF-1
 S PATIEN=$G(RXDAT(52,RXIENS,2,"I"))
 ; for now, set priority to routine
 S VAPRIOR="R"
 S VADAYS=$G(RXDAT(52,RXIENS,8,"E"))
 S WRITDT=$$GET1^DIQ(52.49,ERXIEN,5.9,"I")
 S ORDERTYP="RNW"
 S PSOHY("PREVORD")=RXIEN
 S PSOHY("LOC")=LOC,PSOHY("CHNUM")=$G(ERXNUM)
 S PSOHY("PICK")=VAROUT,PSOHY("ENTER")=PROVIEN
 S PSOHY("PROV")=PROVIEN,PSOHY("SDT")=EFFDT
 S PSOHY("ITEM")=VAOI,PSOHY("DRUG")=VADRUG
 S PSOHY("QTY")=VQTY,PSOHY("REF")=VAREF
 ; DFN cannot be newed/killed here because it needs to exist for the subsequent call.
 S (PSOHY("PAT"),DFN)=PATIEN,PSOHY("OCC")=ORDERTYP
 ; Login date will always be the Message Received Date/Time
 S PSOHY("EDT")=$$GET1^DIQ(52.49,ERXIEN,.03,"I"),PSOHY("PRIOR")=VAPRIOR
 ; ALWAYS PSO as the external application
 S PSOHY("EXAPP")="PHARMACY"
 S PSOHY("DAYS")=VADAYS
 Q
