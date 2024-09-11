PSOERUT7 ;ALB/MFR - eRx Drug Validation (VD) Utilities; 06/25/2023 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**746**;DEC 1997;Build 106
 ;
DOSEDUE(MODE,NPSPC,ERXIEN,SDERXFLG) ; Sets Dosage & DUE Information
 ; Input: MODE    - Display Mode: "RS": Roll & Scroll | "LM": ListMan
 ;        NMSPC  - ListMan Temp Global Namespace (e.g., "PSOERXP1")
 ;        ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;     (o)SDERXFLG  - Single eRx View/Display Flag - 1: Single eRx View/Display side-by-side | 0: Existing Functionality
 N ERXDOSE,DOSE,XE,XEI,XV,XVI,WRPDOSE,I,DISPUNTS,DOSEX,PDUE,DUESEQ,ERXLINES,VALINES,COAGENT,REASON,RESULT,ACK,VAPATINS
 ;
 D PDUEDATA^PSOERXU9(.PDUE,ERXIEN,1)
 S XEI=0,LMLINE=LINE-1
 S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="Prescriber Drug Use Evaluation:"
 I '$D(PDUE) D
 . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)=" None",HIGHLN(LMLINE,2)=4
 E  D
 . F DUESEQ=1:1 Q:'$D(PDUE(DUESEQ))  D
 . . S COAGENT=$P(PDUE(DUESEQ),"^",8)
 . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="Co-Agent: "_$$COMPARE^PSOERUT0(MODE,$E(COAGENT,1,29),$E(COAGENT,1,29),11,,LMLINE)
 . . I $L(COAGENT)>29 D
 . . . F I=1:1 S COAGENT=$E(COAGENT,30,999) Q:COAGENT=""  D
 . . . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="          "_$$COMPARE^PSOERUT0(MODE,$E(COAGENT,1,29),$E(COAGENT,1,29),11,,LMLINE)
 . . S REASON=$P(PDUE(DUESEQ),"^",2) I $$PRESOLV^PSOERXA1(REASON,"REA") S REASON=$$GET1^DIQ(52.45,$$PRESOLV^PSOERXA1(REASON,"REA"),.02)
 . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="Reason: "_$$COMPARE^PSOERUT0(MODE,$E(REASON,1,30),$E(REASON,1,30),9,,LMLINE)
 . . I $L(REASON)>31 D
 . . . F I=1:1 S REASON=$E(REASON,32,999) Q:REASON=""  D
 . . . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="        "_$$COMPARE^PSOERUT0(MODE,$E(REASON,1,31),$E(REASON,1,31),9,,LMLINE)
 . . S RESULT=$P(PDUE(DUESEQ),"^",4) I $$PRESOLV^PSOERXA1(RESULT,"RES") S RESULT=$$GET1^DIQ(52.45,$$PRESOLV^PSOERXA1(RESULT,"RES"),.02)
 . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="Result: "_$$COMPARE^PSOERUT0(MODE,$E(RESULT,1,30),$E(RESULT,1,30),9,,LMLINE)
 . . I $L(RESULT)>31 D
 . . . F I=1:1 S RESULT=$E(RESULT,32,999) Q:RESULT=""  D
 . . . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="        "_$$COMPARE^PSOERUT0(MODE,$E(RESULT,1,31),$E(RESULT,1,31),9,,LMLINE)
 . . S ACK=$P(PDUE(DUESEQ),"^",9)
 . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="Override: "_$$COMPARE^PSOERUT0(MODE,$E(ACK,1,28),$E(ACK,1,28),11,,LMLINE)
 . . I $L(ACK)>28 D
 . . . F I=1:1 S ACK=$E(ACK,29,999) Q:ACK=""  D
 . . . . S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="                 "_$$COMPARE^PSOERUT0(MODE,$E(ACK,1,28),$E(ACK,1,28),11,,LMLINE)
 . . I $O(PDUE(DUESEQ)) S XEI=XEI+1,LMLINE=LMLINE+1,ERXLINES(XEI)="......................................"
 ;
 D ERXDOSE^PSOERUT4(ERXIEN,.ERXDOSE)
 S XVI=0,LMLINE=LINE-1
 I '$D(ERXDOSE),'$D(PDUE) D
 . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)=$S($G(SDERXFLG):"",MODE="LM":"2)",1:"  ")_$S($G(SDERXFLG):"",1:"   ")_"   Dosage:"
 . I MODE="LM",'$G(SDERXFLG) S UNDERLN(LMLINE,41)=2
 F DOSE=1:1 Q:'$D(ERXDOSE("DOSE",DOSE))  D
 . I '$G(ERXDOSE("DOSE ORDERED",DOSE)) D
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="       Verb: "_$$COMPARE^PSOERUT0(MODE,ERXDOSE("VERB",DOSE),ERXDOSE("VERB",DOSE),54,,LMLINE)
 . S DOSEX=ERXDOSE("DOSE",DOSE) I $E(DOSEX,1)=".",$G(ERXDOSE("DOSE ORDERED",DOSE)) S DOSEX="0"_DOSEX
 . I $G(ERXDOSE("UNITS",DOSE))]"" S DOSEX=DOSEX_" ("_$$GET1^DIQ(50.607,ERXDOSE("UNITS",DOSE),.01)_")"
 . D WRAP^PSOERUT(DOSEX,24,.WRPDOSE)
 . S XVI=XVI+1,LMLINE=LMLINE+1
 . S VALINES(XVI)=$S($G(SDERXFLG):"  ",MODE="LM"&(DOSE=1):"2)",1:"  ")_"   Dosage: "_$$COMPARE^PSOERUT0("LM",$G(WRPDOSE(1,0)),$G(WRPDOSE(1,0)),54,,LMLINE)
 . I MODE="LM",DOSE=1,'$G(SDERXFLG) S UNDERLN(LMLINE,41)=2
 . F I=2:1 Q:'$D(WRPDOSE(I))  D
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="              "_$$COMPARE^PSOERUT0("LM",$G(WRPDOSE(I,0)),$G(WRPDOSE(I,0)),54,,LMLINE)
 . I $G(ERXDOSE("DOSE ORDERED",DOSE)) D
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="       Verb: "_$$COMPARE^PSOERUT0(MODE,$G(ERXDOSE("VERB",DOSE)),$G(ERXDOSE("VERB",DOSE)),54,,LMLINE)
 . . S DISPUNTS=$S($E(ERXDOSE("DOSE ORDERED",DOSE),1)=".":"0",1:"")_ERXDOSE("DOSE ORDERED",DOSE)
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="Disp. Units: "_$$COMPARE^PSOERUT0(MODE,$E(DISPUNTS,1,27),$E(DISPUNTS,1,27),54,,LMLINE)
 . . I $L(DISPUNTS)>27 D
 . . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)=$$COMPARE^PSOERUT0(MODE,$E(DISPUNTS,28,999),$E(DISPUNTS,28,999),41)
 . I $G(ERXDOSE("NOUN",DOSE))'="" D
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="       Noun: "_$$COMPARE^PSOERUT0(MODE,ERXDOSE("NOUN",DOSE),ERXDOSE("NOUN",DOSE),54,,LMLINE)
 . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="      Route: "_$$COMPARE^PSOERUT0(MODE,$G(ERXDOSE("ROUTE",DOSE)),$G(ERXDOSE("ROUTE",DOSE)),54,,LMLINE)
 . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="   Schedule: "_$$COMPARE^PSOERUT0(MODE,$G(ERXDOSE("SCHEDULE",DOSE)),$G(ERXDOSE("SCHEDULE",DOSE)),54,,LMLINE)
 . I $G(ERXDOSE("DURATION",DOSE))'="" D
 . . N DUR S DUR=ERXDOSE("DURATION",DOSE)
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="   Duration: "_$$COMPARE^PSOERUT0(MODE,DUR_" "_$$FREQ^PSOERUT4(DUR),DUR_" "_$$FREQ^PSOERUT4(DUR),54,,LMLINE)
 . I $G(ERXDOSE("CONJUNCTION",DOSE))'="" D
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="Conjunction: "_$$COMPARE^PSOERUT0(MODE,ERXDOSE("CONJUNCTION",DOSE),ERXDOSE("CONJUNCTION",DOSE),54,,LMLINE)
 ;
 ; - Patient Instructions
 S VAPATINS=$$GET1^DIQ(52.49,ERXIEN,27)
 I $G(VAPATINS)'=""!(MODE="LM") D
 . I MODE="LM",'$G(SDERXFLG) S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)="________________________________________"
 . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)=$S($G(SDERXFLG):"",MODE="LM":"3)",1:"")_"Patient Instructions:"
 . I MODE="LM",'$G(SDERXFLG) S UNDERLN(LMLINE,41)=2
 . K VARR D WRAP^PSOERUT($G(VAPATINS),39,.VARR)
 . F I=1:1 Q:'$D(VARR(I))  D
 . . S XVI=XVI+1,LMLINE=LMLINE+1,VALINES(XVI)=" "_$$COMPARE^PSOERUT0(MODE,$G(VARR(I,0)),$G(VARR(I,0)),42,,LMLINE)
 ;
 ; - Setting eRx Prescriber Drug Use Evaluation (DUE), Matched Dosage and Patient Instructions
 F ALLLN=1:1 Q:('$D(ERXLINES(ALLLN))&'$D(VALINES(ALLLN)))  D
 . S ERXALLS=$G(ERXLINES(ALLLN)),VAALLS=$G(VALINES(ALLLN))
 . S XE=$G(ERXLINES(ALLLN))
 . S XV="|"_$G(VALINES(ALLLN))
 . D ADDLINE^PSOERUT0(MODE,NMSPC,XE,XV)
 Q
 ;
SAMEDOSE(ERX,RX) ; Returns if the eRx Dosage and VistA Rx Dosage are the same
 ; Input: ERX - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;        RX  - Pointer to PRESCRIPTION file (#52)
 ;Output: SAMEDOSE - 1: Exact same Dose | 0 - Different Dose
 N SAMEDOSE,EDOSE,VDOSE,NEXTE,NEXTV
 D ERXDOSE^PSOERUT4(ERX,.EDOSE,1)
 D VARXDOSE^PSOERUT4(RX,.VDOSE)
 S SAMEDOSE=1
 S NEXTE="EDOSE" F  S NEXTE=$Q(@NEXTE) Q:NEXTE=""  D  I 'SAMEDOSE Q
 . S NEXTV="VDOSE("_$P(NEXTE,"(",2)
 . I $G(@NEXTE)'=$G(@NEXTV) S SAMEDOSE=0
 Q SAMEDOSE
