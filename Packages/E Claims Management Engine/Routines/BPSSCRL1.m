BPSSCRL1 ;AITC/CKB - ECME LOGINFO ;06/01/2017
 ;;1.0;E CLAIMS MGMT ENGINE;**22,24**;JUN 2004;Build 43
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Call to $$NCPDPQTY^PSSBPSUT supported by IA# 4992
 ; Moved from BPSSCRLG
 Q
 ;
PREPINFO(BPLN,BPDFN,BP36,BP59) ;
 ;input:
 ; BPDFN: patient ien #2
 ; BP36: insurance ien #36
 ; BP59: ptr to #9002313.59
 ; returns # of lines
 N BPSECME
 I '$G(BP59) Q 0
 I '$G(BP36) Q 0
 I '$G(BPDFN) Q 0
 N BPSCRLNS S BPSCRLNS=17 ;(see "BPS LSTMN LOG" LM template: Bottom=21, Top = 4, 21-4=17)
 N BPX,BPRXIEN,BPRXN,BPREF,BP1,BPLSTCLM,BPLSTRSP,BPDAT59,BPUSR,BPSTRT,BPHIST,BPQ
 N BPDT,BPLN0,BPCNT,DFN,VADM
 S DFN=BPDFN D DEM^VADPT
 S BP1=$$RXREF^BPSSCRU2(BP59)
 S BPRXIEN=$P(BP1,U,1)
 S BPRXN=$$RXNUM^BPSSCRU2(+BPRXIEN)
 S BPREF=$P(BP1,U,2)
 S BPDAT59(0)=$G(^BPST(BP59,0))
 ;create history
 D MKHIST^BPSSCRU5(BP59,.BPHIST)
 ;
 S BPLN0=BPLN
 D SETLINE^BPSSCRLG(.BPLN,"Pharmacy ECME Log")
 D SETLINE^BPSSCRLG(.BPLN,"")
 S BPX=$$RJ^BPSSCR02("Rx #: ",20)_BPRXN_"/"_BPREF
 S BPSECME=$$ECMENUM^BPSSCRU2(BP59)
 S BPX=BPX_$$RJ^BPSSCR02("ECME #: ",20)_BPSECME
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 S BPX=$$RJ^BPSSCR02("Drug: ",20)_$$DRGNAM^BPSSCRU2($$GETDRG59^BPSSCRU2(BP59))
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 S BPX=$$RJ^BPSSCR02("Patient: ",20)
 S BPX=BPX_$$LJ^BPSSCR02($$PATNAME^BPSSCRU2(BPDFN)_" "_$$SSN4^BPSSCRU2(BPDFN),25)
 S BPX=BPX_$$LJ^BPSSCR02("Sex: "_$P($G(VADM(5)),"^",1),10)
 S BPX=BPX_$$LJ^BPSSCR02("DOB: "_$P($G(VADM(3)),"^",2)_"("_$G(VADM(4))_")",20)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 S BPX=$$RJ^BPSSCR02("Transaction Number: ",20)
 S BPX=BPX_$P($G(^BPST(BP59,0)),U,1)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 S BPX=$$RJ^BPSSCR02("Last Submitted: ",20)
 S BPSTRT=$P(BPDAT59(0),U,11) ;@# need to check with analyst if this is a START DATE
 I BPSTRT]"" S BPX=BPX_$$DATETIME^BPSSCRU5(BPSTRT)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 S BPX=$$RJ^BPSSCR02("Last Submitted By: ",20)
 S BPUSR=$P(BPDAT59(0),U,10)
 I BPUSR]"" S BPX=BPX_$$GETUSRNM^BPSSCRU1(BPUSR)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 ;
 ;latest claim
 S BP1=+$O(BPHIST("C",99999999),-1)
 I BP1=0 D SETLINE^BPSSCRLG(.BPLN,""),SETLINE^BPSSCRLG(.BPLN,"------ No electronic claims ------") Q BPLN
 S BP1=+$O(BPHIST("C",BP1,0))
 S BPX=$$RJ^BPSSCR02("Last VA Claim #: ",20)_$P($G(^BPSC(+BP1,0)),U,1)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 F BPCNT=BPLN:1:BPLN0+BPSCRLNS D SETLINE^BPSSCRLG(.BPLN,"")
 ;process history
 N BPTYPE,BPIEN,BPIENRS
 S BPDT=99999999
 F  S BPDT=$O(BPHIST("C",BPDT),-1) Q:+BPDT=0  D
 . S BPIEN=+$O(BPHIST("C",BPDT,0)) Q:BPIEN=""
 . D DISPCLM(.BPLN,BP59,BPIEN,+BPHIST("C",BPDT,BPIEN),$P(BPHIST("C",BPDT,BPIEN),U,2),BPDT)
 . S BPIENRS=0
 . F  S BPIENRS=$O(BPHIST("C",BPDT,BPIEN,"R",BPIENRS)) Q:+BPIENRS=0  D
 . . D DISPRSP(.BPLN,BP59,BPIENRS,+BPHIST("C",BPDT,BPIEN,"R",BPIENRS),$P(BPHIST("C",BPDT,BPIEN,"R",BPIENRS),U,2),BPDT)
 . . D DISPPYR^BPSSCRLG(.BPLN,BPIENRS)
 Q BPLN
 ;
 ;display claim record
DISPCLM(BPLN,BP59,BPIEN02,BP57,BPSTYPE,BPSDTALT) ;
 N BPSCRLNS S BPSCRLNS=17 ;(see "BPS LSTMN LOG" LM template: Bottom=21, Top = 4, 21-4=17)
 N BPX,BPLN0,BPCNT,BPSTR1,BPSTYP2,BPNFLDT,BPUNITS
 ;
 S BPLN0=BPLN
 S BPSTYP2=$S(BPSTYPE="C":"CLAIM REQUEST",BPSTYPE="R":"REVERSAL",1:"")
 S BPSTR1="Transmission Information ("_BPSTYP2_")(#"_BPIEN02_")"
 D SETLINE^BPSSCRLG(.BPLN,BPSTR1_$$LINE^BPSSCRU3(79-$L(BPSTR1),"-"))
 D SETLINE^BPSSCRLG(.BPLN,"Created on: "_$$CREATEDT^BPSSCRLG(BPIEN02,BPSDTALT))
 D SETLINE^BPSSCRLG(.BPLN,"VA Claim ID: "_$P($G(^BPSC(+BPIEN02,0)),U,1))
 D SETLINE^BPSSCRLG(.BPLN,"Submitted By: "_$$SUBMTBY^BPSSCRLG(BP57))
 D SETLINE^BPSSCRLG(.BPLN,"Transaction Type: "_$$TRTYPE^BPSSCRU5($$TRCODE^BPSSCRLG(BPIEN02)))
 D SETLINE^BPSSCRLG(.BPLN,"Date of Service: "_$$DOSCLM^BPSSCRLG(BPIEN02))
 ;Display Next Available Fill Date - BPS*1.0*15
 S BPNFLDT=$$NFLDT^BPSBUTL(BPRXIEN,BPREF,$$RXCOB57^BPSSCRLG(BP57))
 D:BPNFLDT SETLINE^BPSSCRLG(.BPLN,"Next Available Fill Date: "_$$FMTE^XLFDT(BPNFLDT,"2ZM"))
 D SETLINE^BPSSCRLG(.BPLN,"NDC Code: "_$$LNDC^BPSSCRU5(BPIEN02))
 ;
 S BPUNITS=$$UNITS^BPSSCRLG(BPIEN02)
 ; if BPUNITS is null get the BPUNITS from the PRESCRIPTION file (#52)
 I BPUNITS="(  )" S BPUNITS=$$GETUNIT(BPRXIEN,$G(BPREF))
 D SETLINE^BPSSCRLG(.BPLN,"Quantity Submitted on Claim: "_$$QTY^BPSSCRLG(BPIEN02)_" "_BPUNITS)
 ;
 D SETLINE^BPSSCRLG(.BPLN,"Days Supply: "_$$DAYSSUPL^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"Division: "_$$DIV^BPSSCRLG(BP57))
 D SETLINE^BPSSCRLG(.BPLN,"NPI#: "_$$NPI^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"Prescriber DEA Number: "_$$PDEA^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"ECME Pharmacy: "_$$DIVNAME^BPSSCRDS($$LDIV^BPSSCRLG(BP57)))
 D SETLINE^BPSSCRLG(.BPLN,"Total Prescribed Quantity Remaining: "_$$TOTPQR^BPSSCRLG(BPIEN02))
 S BPX="Rx Qty: "_$$BILLQTY^BPSSCRLG(BP57)_" "_$$BILLUNT^BPSSCRLG(BP57)
 S BPX=BPX_"     Unit Cost: "_$$UNTPRICE^BPSSCRLG(BP57)
 S BPX=BPX_"     Gross Amt Due: "_$$TOTPRICE^BPSSCRLG(BPIEN02)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 S BPX="Ingredient Cost: "_$$INGRCST^BPSSCRLG(BPIEN02)
 S BPX=BPX_"     Dispensing Fee: "_$$DISPFEE^BPSSCRLG(BPIEN02)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 S BPX="U&C Charge: "_$$UCCHRG^BPSSCRLG(BPIEN02)
 S BPX=BPX_"     Admin Fee: "_$$ADMNFEE^BPSSCRLG(BPIEN02)
 D SETLINE^BPSSCRLG(.BPLN,BPX)
 D SETLINE^BPSSCRLG(.BPLN,"")
 D SETLINE^BPSSCRLG(.BPLN,"Insurance Name: "_$$INSUR57^BPSSCRLG(BP57))
 D SETLINE^BPSSCRLG(.BPLN,"Group Name: "_$$GRPNM^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"Rx Coordination of Benefits: "_$$RXCOB57^BPSSCRLG(BP57))
 D SETLINE^BPSSCRLG(.BPLN,"Pharmacy Plan ID: "_$$PHPLANID^BPSSCRLG(BP57))
 D SETLINE^BPSSCRLG(.BPLN,"BIN: "_$$BIN^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"PCN: "_$$PCN^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"NCPDP Version: "_$$GETVER^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"Group ID: "_$$GRPID^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"Cardholder ID: "_$$CRDHLDID^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"Patient Relationship Code: "_$$PATRELSH^BPSSCRLG(BPIEN02))
 D SETLINE^BPSSCRLG(.BPLN,"Cardholder First Name: "_$$CRDHLDFN^BPSSCRLG(BPIEN02,BP57))
 D SETLINE^BPSSCRLG(.BPLN,"Cardholder Last Name: "_$$CRDHLDLN^BPSSCRLG(BPIEN02,BP57))
 ; BPS*1*22
 D SETLINE^BPSSCRLG(.BPLN,"Facility ID Qualifier: "_$$FACIDQ^BPSSCRLG(BPIEN02))
 F BPCNT=BPLN:1:BPLN0+BPSCRLNS D SETLINE^BPSSCRLG(.BPLN,"")
 S BPLN0=BPLN
 D SETLINE^BPSSCRLG(.BPLN,"Billing Request Payer Sheet: "_$$B1PYRIEN^BPSSCRU5(BP57))
 D SETLINE^BPSSCRLG(.BPLN,"Reversal Payer Sheet: "_$$B2PYRIEN^BPSSCRU5(BP57))
 D SETLINE^BPSSCRLG(.BPLN,"VA Claim ID: "_$P($G(^BPSC(+BPIEN02,0)),U,1))
 D SETLINE^BPSSCRLG(.BPLN,"")
 Q
 ;
GETUNIT(BPRXIEN,BPREF) ; Return the NCPDP Dispense Unit 
 ; Input: (r) BPRXIEN - Quantity dispensed from the PRESCRIPTION file (#52)
 ;             BPREF  - Rx Refill 
 ;0utput:     BPUNITS - Billing Quantity (3 decimal places)^NCPDP Dispense Unit (EA, GM or ML)
 ;
 N BPDRUG,BPQTY,BPUNITS,Z
 ;
 ; Find NCPDP Dispense Unit from PRESCRIPTION file (#52)
 S BPDRUG=$$GET1^DIQ(52,BPRXIEN,6,"I")
 S BPQTY=$S($G(BPREF)="":$$GET1^DIQ(52,BPRXIEN,7,"I"),1:$$GET1^DIQ(52.1,BPREF_","_BPRXIEN,1))/1
 S Z=$$NCPDPQTY^PSSBPSUT(BPDRUG,BPQTY)
 S BPUNITS=$P(Z,"^",2)
 Q "("_BPUNITS_")"
 ;
 ;display response record
DISPRSP(BPLN,BP59,BPIEN03,BP57,BPSTYPE,BPSDTALT) ;
 N BPSCRLNS S BPSCRLNS=17 ;(see "BPS LSTMN LOG" LM template: Bottom=21, Top = 4, 21-4=17)
 N BPX,BPLN0,BPCNT,BPRJCDS,BPRJ,BPSTR1,BPSTYP2,BDUR,BMSG,PTRESP
 S BPLN0=BPLN
 S BPSTYP2=$S(BPSTYPE="C":"CLAIM REQUEST",BPSTYPE="R":"REVERSAL",1:"")
 S BPSTR1="Response Information  ("_BPSTYP2_")(#"_BPIEN03_")"
 D SETLINE^BPSSCRLG(.BPLN,BPSTR1_$$LINE^BPSSCRU3(79-$L(BPSTR1),"-"))
 D SETLINE^BPSSCRLG(.BPLN,"Response Received: "_$$RESPREC^BPSSCRLG(BPIEN03,BPSDTALT))
 D SETLINE^BPSSCRLG(.BPLN,"Date of Service: "_$$DOSRSP^BPSSCRLG(BPIEN03))
 D SETLINE^BPSSCRLG(.BPLN,"Transaction Response Status: "_$$RESPSTAT^BPSSCRU5(BPIEN03))
 D SETLINE^BPSSCRLG(.BPLN,"Total Amount Paid: $"_$$TOTAMNT^BPSSCRLG(BPIEN03))
 D SETLINE^BPSSCRLG(.BPLN,"Ingredient Cost Paid: $"_$$ICPAID^BPSSCRLG(BPIEN03)_"   Dispensing Fee Paid: $"_$$DFPAID^BPSSCRLG(BPIEN03))
 S PTRESP=$$PTRESP^BPSSCRLG(BPIEN03) S PTRESP=$S(PTRESP="":"$",PTRESP="0.00":"$0",1:"($"_PTRESP_")")
 D SETLINE^BPSSCRLG(.BPLN,"Patient Resp (INS): "_PTRESP)
 ; BPS*1*22
 D SETLINE^BPSSCRLG(.BPLN,"Reconciliation ID: "_$$RECONID^BPSSCRLG(BPIEN03))
 D SETLINE^BPSSCRLG(.BPLN,"Reject code(s): ")
 D REJCODES^BPSSCRU5(BPIEN03,.BPRJCDS)
 S BPRJ=""
 F  S BPRJ=$O(BPRJCDS(BPRJ)) Q:BPRJ=""  D
 . D SETLINE^BPSSCRLG(.BPLN," "_$$GETRJNAM^BPSSCRU3(BPRJ))
 D WRAPLN^BPSSCRU5(.BPLN,$$MESSAGE^BPSSCRLG(BPIEN03),76,"Payer Message: ",5)
 D ADDMESS^BPSSCRLG(BPIEN03,1,.BPADDMSG)
 S BMSG="" F  S BMSG=$O(BPADDMSG(BMSG)) Q:BMSG=""  D
 . D WRAPLN^BPSSCRU5(.BPLN,BPADDMSG(BMSG),76,$S(BMSG=1:"Payer Additional Message: ",1:"     "),5)
 D SETLINE^BPSSCRLG(.BPLN,"Reason for Service Code: "_$$DURREAS^BPSSCRLG(BPIEN03))
 D SETLINE^BPSSCRLG(.BPLN,"DUR Text: "_$$DURTEXT^BPSSCRLG(BPIEN03))
 D WRAPLN^BPSSCRU5(.BPLN,$$DURADD^BPSSCRLG(BPIEN03),76,"DUR Additional Text: ",5)
 ; BPS*1*18:  Print Claim Log [BPS PRTCL USRSCR CLAIM LOG] (when included in the incoming response)
 D SETLINE^BPSSCRLG(.BPLN,"HPID/OEID: "_$$HPID^BPSSCRLG(BPIEN03,BP57))
 F BPCNT=1:1:2 D SETLINE^BPSSCRLG(.BPLN,"")
 Q
 ;
