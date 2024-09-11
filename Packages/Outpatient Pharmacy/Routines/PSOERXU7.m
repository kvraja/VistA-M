PSOERXU7 ;ALB/BLB,RM - eRx Utilities/RPC's ; 11/27/2019 11:02am
 ;;7.0;OUTPATIENT PHARMACY;**581,617,700,746**;DEC 1997;Build 106
 ;
 Q
MEDDIS(ERXIEN,LINE) ;
 N DRUG,DIEN,QTY,DAYS,WDATE,EFDATE,REFILL,EXDATE,LFDATE,DIRECT,CLQ,USC,PUC,F,IENS,I,LTXT
 N RXIEN,RXNUM,INS,DDAT,PARIEN,OREFILL,DLOOP,DIARY,MIEN,MTYPE,DATAIEN,QUOM,SIG1TXT,SIG1ARY,II
 S F=52.49311
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"****************************MEDICATION DISPENSED****************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                              MEDICATION DISPENSED                            "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 S PARIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I PARIEN S RXIEN=$$GET1^DIQ(52.49,PARIEN,.13,"I")
 I $G(RXIEN) S OREFILL=$$GET1^DIQ(52,RXIEN,9,"E")
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I MTYPE="RE" S DATAIEN=$$GETREQ^PSOERXU2(ERXIEN)
 I MTYPE="RR" S DATAIEN=ERXIEN
 S MIEN=0 F  S MIEN=$O(^PS(52.49,DATAIEN,311,"C","D",MIEN)) Q:'MIEN  D
 .S IENS=MIEN_","_DATAIEN_","
 .D GETS^DIQ(F,IENS,".03;2.1;2.3;2.4;2.5;2.8","IE","DDAT")
 .S DRUG=$G(DDAT(F,IENS,.03,"E"))
 .S:DRUG'="" DIEN=$O(^PSDRUG("B",DRUG,0))
 .S QTY=$G(DDAT(F,IENS,2.1,"E"))
 .S DAYS=$G(DDAT(F,IENS,2.4,"E"))
 .S REFILL=$G(DDAT(F,IENS,2.8,"E"))
 .S WDATE=$G(DDAT(F,IENS,2.5,"E"))
 .S I=$G(DDAT(F,IENS,2.3,"I"))
 .S QUOM=$$CODEDESC(I)
 .; if there is an RX ien, reset the refills to that value - may need to adjust other fields as well
 .I $G(RXIEN) S REFILL=$$GET1^DIQ(52,RXIEN,9,"E")
 .S LINE=LINE+1 D SET^VALM10(LINE,"Vista Drug: "_DRUG_" "_$P($$VADRSCH^PSOERXUT(+$G(DIEN)),"^",3)),CNTRL^VALM10(LINE,13,68,$G(IOINHI),$G(IOINORM))
 .S LINE=LINE+1
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Qty: ",$G(QTY),1,25)
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Refills: ",$G(REFILL),27,18)
 .D ADDITEM^PSOERX1A(.LTXT,"Vista Days Supply: ",$G(DAYS),54,22)
 .D SET^VALM10(LINE,LTXT)
 .I $G(SDERXFLG) D
 . . D CNTRL^VALM10(LINE,12,10,$G(IOINHI),$G(IOINORM)) ;Vista Qty
 . . D CNTRL^VALM10(LINE,43,10,$G(IOINHI),$G(IOINORM)) ;Vista Refills
 . . D CNTRL^VALM10(LINE,74,7,$G(IOINHI),$G(IOINORM)) ;Vista Days Supply
 .S LTXT=""
 .S LINE=LINE+1 D SET^VALM10(LINE,"Quantity Unit Of Measure: "_QUOM),CNTRL^VALM10(LINE,27,$L($G(QUOM)),$G(IOINHI),$G(IOINORM))
 I $G(RXIEN) D
 .S RXNUM=$$GET1^DIQ(52,RXIEN,.01,"E"),SIG1TXT=""
 .S INS=0 F  S INS=$O(^PSRX(RXIEN,"SIG1",INS)) Q:'INS  S SIG1TXT=SIG1TXT_$G(^PSRX(RXIEN,"SIG1",INS,0))_" "
 .D TXT2ARY^PSOERXD1(.SIG1ARY,SIG1TXT," ",75)
 .S II=0 F  S II=$O(SIG1ARY(II)) Q:'II  D
 ..S LINE=LINE+1 D SET^VALM10(LINE,$S(II=1:"Vista Sig: ",1:$J("",11))_SIG1ARY(II)),CNTRL^VALM10(LINE,11,80,$G(IOINHI),$G(IOINORM))
 I '$L($G(RXNUM)) S RXNUM="Unable to resolve."
 S LINE=LINE+1 D SET^VALM10(LINE,"VA Rx#: "_$G(RXNUM)),CNTRL^VALM10(LINE,9,$L($G(RXNUM)),$G(IOINHI),$G(IOINORM))
 Q
 ; CODE - code value such as C12345 (.01 value in file 52.45)
 ; TYPE - The type of code you are looking for such as "NCI", "CLQ", "RES", etc.
CODERES(CODE,TYPE) ;
 Q:TYPE=""!(CODE="") ""
 N IEN
 S IEN=$O(^PS(52.45,"C",TYPE,CODE,0))
 Q $$CODEDESC(IEN)
 ; IEN - ien of the code in file 52.45
CODEDESC(IEN) ;
 Q $$GET1^DIQ(52.45,IEN,.02,"E")
GETPTPH(PATIEN,S2017,CODES) ; Get Patient primary telephone
 N CIEN,CODE,EXT,FILE,IENS,PATEL,SUB,TYPE
 I S2017 D
 .S CODE=$P(CODES,",")
 .S PATEL=$$COMMVAL^PSOERXU5(PATIEN,52.46,13,CODE)
 I 'S2017 D
 .S SUB=3,CODE=$P(CODES,",",2),FILE=52.462
 .S PATEL=""
 .S CIEN=$O(^PS(52.46,PATIEN,SUB,"C",CODE,0))
 .I CIEN D
 ..S IENS=CIEN_","_PATIEN_","
 ..S PATEL=$$GET1^DIQ(FILE,IENS,.01,"I")
 .I 'CIEN D
 ..S CIEN=0
 ..F  S CIEN=$O(^PS(52.46,PATIEN,SUB,CIEN)) Q:CIEN'?1.N  D  Q:PATEL]""
 ...S IENS=CIEN_","_PATIEN_","
 ...S PATEL=$$GET1^DIQ(FILE,IENS,.01,"I")
 ...S TYPE=$$GET1^DIQ(FILE,IENS,.02,"I")
 ...S:TYPE="EM" PATEL=""
 .I PATEL]"" D
 ..S EXT=$$GET1^DIQ(FILE,IENS,.03,"I")
 ..S:EXT]"" PATEL=PATEL_"X"_EXT
 ;/JSG/ PSO*7.0*581 - END CHANGE
 Q PATEL
RXEPRMT(ERXIEN) ;
 N DIR,Y,RES,ERXSTAT,MTYPE,NSTAT
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S RES=""
 S DIR(0)="YO"
 W !,"There was a processing error."
 W !,"Please validate that the eRx was discontinued in Outpatient Pharmacy and/or"
 W !,"canceled in the Holding Queue."
 S DIR("A")="Would you like to continue to process the record?"
 S DIR("B")="YES"
 D ^DIR
 ; if they wish to continue, update the status to RXI
 S NSTAT=$S(MTYPE="RE":"RXI",1:"CXI")
 I Y S RES=Y D UPDSTAT^PSOERXU1(ERXIEN,NSTAT)
 Q RES
OPACCESS(OPTION,DUZ,ERXIEN) ;
 N MTYPE,EVAL,RESVAL,MSTAT,DELTA,RET,RESIEN,REQIEN,RESCHECK,MESREQ,MBMALLOW
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I")
 S MSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 S RESVAL=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 I MSTAT="CXE",($G(OPTION)'["PSO ERX VALIDATE") Q 0
 S MESREQ=$$GET1^DIQ(52.49,PSOIEN,315.1,"E")
 I MTYPE="CX"!(MTYPE="CR"),$E(RESVAL)'="V",($E(RESVAL)'="A"!(",G,T,S,OS,D,"'[MESREQ)) Q 0
 I MSTAT="CXP"!(MSTAT="CXQ")!(MSTAT="CXC") Q 0
 I MSTAT="CRE" Q 0
 I MSTAT="RRE"!(MSTAT="RRN") Q 0
 I MTYPE="RE",((RESVAL="D")!(RESVAL="DNP"))!(RESVAL="A") Q 0
 I MTYPE="RE",(MSTAT="RXP")!(MSTAT="RXC")!(MSTAT="RRC") Q 0
 I MTYPE="RE",$G(OPTION)["HOLD",MSTAT="RXE" Q 0
 I MTYPE="RR",(MSTAT="RRC")!(MSTAT="RRR") Q 0
 I (MTYPE="RE")!(MTYPE="RR"),(MSTAT="CAN")!(MSTAT="RXD")!(MSTAT="RRP") Q 0
 I MTYPE="CA"!(MTYPE="CN")!(MTYPE="IE") Q 0
 I MTYPE="N",$$GET1^DIQ(52.49,PSOIEN,1,"E")="CAN" Q 0
 ; MbM Only - Change to allow users to validate Patient, Provider and Drug for records on Hold, as well as Accept Validation
 S MBMALLOW=0
 I $$GET1^DIQ(59.7,1,102,"I")="MBM",$E(MSTAT)="H",'$D(^XUSEC("PSO ERX VIEW",DUZ)) D  I $G(MBMALLOW) Q 1
 . I OPTION="PSO ERX VALIDATE PATIENT" S MBMALLOW=1
 . I OPTION="PSO ERX VALIDATE PROVIDER" S MBMALLOW=1
 . I OPTION="PSO ERX VALIDATE DRUG" S MBMALLOW=1
 . I OPTION="PSO ERX ACCEPT VALIDATION" S MBMALLOW=1
 I $E(MSTAT)="H",OPTION'["UNHOLD",OPTION'["PRINT",OPTION'["HISTORY",OPTION'["REMOVE" Q 0
 I OPTION="PSO ERX ACCEPT ERX",(RESVAL="AWC"!(RESVAL="R")),MTYPE="RE",(MSTAT="RXN"!(MSTAT="RXW")) D  Q RET
 .S RET=0 I ('$D(^XUSEC("PSDRPH",DUZ))),('$D(^XUSEC("PSO ERX ADV TECH",DUZ))) Q
 .I MSTAT="RXW" S RET=1 Q
 .S RESIEN=PSOIEN,REQIEN=$$GETREQ^PSOERXU2(PSOIEN)
 .D RRDELTA^PSOERXU2(.DELTA,REQIEN,RESIEN)
 .I $D(DELTA(52.49,"EXTERNAL PROVIDER")) S RET=1
 ; block all but accept erx on eRx's in RXW status
 I OPTION'="PSO ERX ACCEPT ERX",MSTAT="RXW",RESVAL'="R" Q 0
 ;
 I OPTION="PSO ERX UNHOLD",($D(^XUSEC("PSO ERX VIEW",DUZ))) Q 0
 I OPTION="PSO ERX REJECT"!(OPTION="PSO ERX REMOVE"),MSTAT="RXE" Q 0
 I OPTION="PSO ERX REJECT"!(OPTION="PSO ERX REMOVE")!(OPTION="PSO ERX HOLD")!(OPTION="PSO ERX UNHOLD"),MSTAT="RXN" Q 0
 I OPTION="PSO ERX ACCEPT ERX",('$D(^XUSEC("PSDRPH",DUZ))),('$D(^XUSEC("PSO ERX ADV TECH",DUZ))) Q 0
 I OPTION="PSO ERX ACCEPT VALIDATION",$D(^XUSEC("PSO ERX VIEW",DUZ)) Q 0
 I OPTION="PSO ERX REJECT",($D(^XUSEC("PSO ERX VIEW",DUZ))) Q 0
 I OPTION="PSO ERX REMOVE",($D(^XUSEC("PSO ERX VIEW",DUZ))) Q 0
 I OPTION="PSO ERX VALIDATE PATIENT",$D(^XUSEC("PSO ERX VIEW",DUZ)) Q 0
 I OPTION="PSO ERX VALIDATE PROVIDER",$D(^XUSEC("PSO ERX VIEW",DUZ)) Q 0
 I OPTION="PSO ERX VALIDATE DRUG",$D(^XUSEC("PSO ERX VIEW",DUZ)) Q 0
 I OPTION="PSO ERX HOLD",$D(^XUSEC("PSO ERX VIEW",DUZ)) Q 0
 Q 1
ERRDISP(ERXIEN,LINE) ;
 N ECODE,ETEXT,EDECODE,EDICODE,I,ERRDTTM
 S ECODE=$$GET1^DIQ(52.49,ERXIEN,60.1,"E")
 S ETEXT=$$GET1^DIQ(52.49,ERXIEN,60,"E")
 S ERRDTTM=$$GET1^DIQ(52.49,ERXIEN,.03,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"*****************************ERROR DETAILS********************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                                ERROR DETAILS                                "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Error Date/Time: "_ERRDTTM),CNTRL^VALM10(LINE,18,$L(ERRDTTM),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Code: "_ECODE),CNTRL^VALM10(LINE,7,$L(ECODE),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Details: "_ETEXT),CNTRL^VALM10(LINE,10,$L(ETEXT),$G(IOINHI),$G(IOINORM))
 I $D(^PS(52.49,ERXIEN,61)) D
 .I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 .S LINE=LINE+1 D SET^VALM10(LINE,"Description Codes")
 .S LINE=LINE+1 D SET^VALM10(LINE,"=================")
 .I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S I=0 F  S I=$O(^PS(52.49,ERXIEN,61,I)) Q:'I  D
 .S EDECODE=$$GET1^DIQ(52.4961,I_","_ERXIEN_",",.01,"E")
 .S EDICODE=$$GET1^DIQ(52.4961,I_","_ERXIEN_",",.01,"I")
 .S LINE=LINE+1 D SET^VALM10(LINE,EDICODE_" - "_EDECODE),CNTRL^VALM10(LINE,1,$L(EDICODE_" - "_EDECODE),$G(IOINHI),$G(IOINORM))
 Q
 ;
 ; refill request information
RRREQ(ERXIEN,LINE) ;
 N REQBY,REQDTTM,REFREQ,COMM,COMMARY,I,COMMBY,COMMDTTM,CTXT,REQIEN,S2017
 S REQIEN=ERXIEN
 I $$GET1^DIQ(52.49,ERXIEN,.08,"I")="RE" S REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 S REQBY=$$GET1^DIQ(52.49,REQIEN,51.1,"E")
 S REFREQ=$$GET1^DIQ(52.49,REQIEN,51.2,"E")
 S REQDTTM=$$GET1^DIQ(52.49,REQIEN,.03,"E")
 S COMM=$$GET1^DIQ(52.49,REQIEN,50,"E")
 S S2017=$$GET1^DIQ(52.49,ERXIEN,312.1)
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"************************RXRENEWAL REQUEST INFORMATION**************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                        RXRENEWAL REQUEST INFORMATION                          "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Requested By: "_REQBY),CNTRL^VALM10(LINE,15,$L(REQBY),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Request Date/Time: "_REQDTTM),CNTRL^VALM10(LINE,20,$L(REQDTTM),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"# of Refills Requested: "_REFREQ),CNTRL^VALM10(LINE,25,$L(REFREQ),$G(IOINHI),$G(IOINORM))
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S COMM="RxRenewal Request Comments: "_COMM
 D TXT2ARY^PSOERXD1(.COMMARY,COMM," ",80)
 S I=0 F  S I=$O(COMMARY(I)) Q:'I  D
 .S CTXT=$G(COMMARY(I))
 .S LINE=LINE+1 D SET^VALM10(LINE,CTXT)
 .I I=1 D CNTRL^VALM10(LINE,29,$L($P(CTXT,":",2)),$G(IOINHI),$G(IOINORM)) Q
 .D CNTRL^VALM10(LINE,1,$L(CTXT),$G(IOINHI),$G(IOINORM))
 S COMMBY=$$GET1^DIQ(52.49,REQIEN,50.1,"E")
 S COMMDTTM=$$GET1^DIQ(52.49,REQIEN,50.2,"E")
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments By: "_COMMBY),CNTRL^VALM10(LINE,14,$L(COMMBY),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Comments Date/Time: "_COMMDTTM),CNTRL^VALM10(LINE,21,$L(COMMDTTM),$G(IOINHI),$G(IOINORM))
 Q
 ;
MSGHIS(ERXIEN,LINE) ;
 N FLAG
 S FLAG=+$G(FLAG)
 N ERXREF,RELERX,ERXRES,I,ERXHID,FOUND,REQID,RESID,MTYPE
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 I ",RR,CA,CR,"[(","_MTYPE_",") S REQIEN=ERXIEN,RESIEN=$$GETRESP^PSOERXU2(ERXIEN)
 I ",RE,CN,CX,"[(","_MTYPE_",") S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 I MTYPE="IE" S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 S RESID=$$GET1^DIQ(52.49,RESIEN,.01,"E")
 S REQID=$$GET1^DIQ(52.49,REQIEN,.01,"E")
 S RELERX=$$GET1^DIQ(52.49,REQIEN,.14)
 S FOUND=0
 S I=ERXIEN F  S I=$O(^PS(52.49,ERXIEN,201,"B",I)) Q:'I!(FOUND)  D
 .I $$GET1^DIQ(52.49,I,.08,"E")="RE",$$GET1^DIQ(52.49,I,.14,"E")=$$GET1^DIQ(52.49,ERXIEN,.01,"E") S ERXRES=$$GET1^DIQ(52.49,I,.14,"E"),FOUND=1
 I '$G(SDERXFLG) S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1 D SET^VALM10(LINE,"*****************************MESSAGE HISTORY********************************")
 I $G(SDERXFLG) D SET^VALM10(LINE,"                                MESSAGE HISTORY                                 "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Request Reference #: "_$G(REQID)),CNTRL^VALM10(LINE,22,$L(REQID),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"New eRx Reference #: "_RELERX),CNTRL^VALM10(LINE,22,$L(RELERX),$G(IOINHI),$G(IOINORM))
 S LINE=LINE+1 D SET^VALM10(LINE,"Response eRx Reference #: "_$G(RESID)),CNTRL^VALM10(LINE,27,$L(RESID),$G(IOINHI),$G(IOINORM))
 Q
 ; displays processing errors
PROCERR(ERXIEN,LINE) ;
 N ERRIEN,ERRIENS,ERRTXT,ERRTARY
 ; quit if there are no processing errors
 Q:'$D(^PS(52.49,ERXIEN,100,"C","PX"))
 S LINE=LINE+1
 I $G(SDERXFLG) D SET^VALM10(LINE,"                            PROCESSING ERRORS                               "),CNTRL^VALM10(LINE,1,80,$G(IOUON)_$G(IOINHI),$G(IOUOFF)_$G(IOINORM))
 E  D
 .D SET^VALM10(LINE,"")
 .S LINE=LINE+1 D SET^VALM10(LINE,"****************************PROCESSING ERRORS*******************************")
 S ERRIEN=0 F  S ERRIEN=$O(^PS(52.49,ERXIEN,100,ERRIEN)) Q:'ERRIEN  D
 .S ERRIENS=ERRIEN_","_ERXIEN_","
 .S ERRTXT=$$GET1^DIQ(52.49101,ERRIENS,1,"E")
 .S ERRTXT="Error Details: "_ERRTXT
 .D TXT2ARY^PSOERXD1(.ERRTARY,ERRTXT," ",78)
 .S I=0 F  S I=$O(ERRTARY(I)) Q:'I  D
 ..S LINE=LINE+1 D SET^VALM10(LINE,$G(ERRTARY(I))),CNTRL^VALM10(LINE,15,$L($G(ERRTARY(I))),$G(IORVON),$G(IORVOFF))
 .K ERRTXT,ERRTARY
 Q
 ;
