PSODOSUT ;BIR/RTR - PRE Dose Check Utility routine ;11/18/08
 ;;7.0;OUTPATIENT PHARMACY;**251,375,372,416,436,402,518**;DEC 1997;Build 3
 ;External reference to ^PSSDSAPI supported by DBIA 5425
 ;
 ;DOSE expect PSODLQT to be defined prior to calling it.
 ; PSODLQT=1 means no data will be written to the screen, but a value will be returned.
 ; PSODLQT=0 means data will be written to the screen and a value is returned 
 ;
 ;EVAL(PSODLINS,PSODLINR) ;
 ;Q $S($G(PSODLINS)&($G(PSODLINR)):"MAX SINGLE DOSE & DAILY DOSE RANGE",$G(PSODLINS):"MAX SINGLE DOSE",$G(PSODLINR):"DAILY DOSE RANGE",1:"UNKNOWN")
 ;
SUMM ;
 I 'PSODLQT W !,"   DOSING CHECK SUMMARY:",!!
 S PSOCPXF=1
 Q
 ;
SUB ;Write sub header; called from PSODOSUN
 D HD^PSODOSU2 Q:$G(PSODLQTC)  I 'PSODLQT,'$G(PSODLEXR) D
 .I '$G(PSOINTRO),$G(PSODLEXR) W ! Q
 .S PSODLEXR=1
 I 'PSODLQT W "   DOSE SEQ "_PSOCPXG_":"
 S PSOCPXRR(PSOCPXG)=1
 Q
 ;
DAILY ;
 Q   ;;removed for Mocha 2.1, might add back for 2.2
 Q:'$G(PSOCPXC)
 I 'PSODLQT W:'$G(PSORENW)!($G(PSOCOPY))!($G(PSORXED)) ! W "   DAILY DOSE RANGE WARNING:"
 S PSODAILY=1
 Q
 ;
COMPLEX ;called from DOSEZ^PSODOSUN
 I 'PSOCPXF&(PSOCPXC) S PSOCPXG=$P(PSODLNN1,";",4) D SUMM K PSODAILY S:PSOCPXC&(PSOCPXG=PSOCPXB) PSOCPXH=1
 I PSOCPXC S PSOCPXG=$P(PSODLNN1,";",4) D HD D
 .I $G(PSOCPXRR(PSOCPXG))&$P(PSODLNN1,";",5)'="" K PSODAILY
 .I '$G(PSOCPXRR(PSOCPXG))&('$G(PSOCPXH)) D SUB I $G(PSOCOPY)!($G(PSORENW)) S:PSOCPXC&(PSOCPXG=PSOCPXB) PSOCPXH=1
 .;I PSODLPL="2_RANGE"&PSODLINR&'$G(PSODAILY) D DAILY          ;removed for Mocha 2.1, might add back for 2.2
 .;I PSODLPL="1_SINGLE_RANGE"&PSODLINX&'$G(PSODAILY) D DAILY   ;removed for Mocha 2.1, might add back for 2.2
 .D HD W:'PSODLQT ! N X,DIWL,DIWR,DIWF S X=PSODLMSG,DIWL=1,DIWR=76 K ^UTILITY($J,"W") D ^DIWP
 .N PSODELXF,PSODELXR S PSODELXF=0 F PSODELXR=0:0 S PSODELXR=$O(^UTILITY($J,"W",DIWL,PSODELXR)) Q:'PSODELXR  D HD W:PSODELXF&('PSODLQT) ! D HD W:'PSODLQT "   "_$G(^UTILITY($J,"W",DIWL,PSODELXR,0)) S PSODELXF=1
 .K ^UTILITY($J,"W")
 .D HD I 'PSODLQT S PSODELNX=$O(^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN1)) I '$P($G(PSODELNX),";",5)!($P($G(PSODELNX),";",4)'=PSOCPXG) W !
 Q
 ;
HD ;
 I $G(PSODLQT)!(($Y+5)<IOSL)!($G(PSORX("DFLG"))) Q
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit" D ^DIR K DIR I 'Y!($D(DTOUT))!($D(DUOUT))!($G(DIRUT)) S PSODLQT=1,PSONEW("DFLG")=1,PSORX("DFLG")=1 Q
 W @IOF
 Q
 ;
SFD ;
 S PSODELXF=1 S:PSODLERX="TEXT" PSODLERZ=1
 Q
 ;
SBAD ;Set Bad Drug flag just in case not set in enhanced check, possibly because Dosage edits are done first
 N PSODLBD1,PSODLBD3
 I PSODLERB["GCNSEQNO"!(PSODLERB["Drug not matched to NDF") D
 .S PSODLBD1=$O(^TMP($J,"PSOPDOSA","OUT","EXCEPTIONS","DOSE",PSODSEQ,PSODLNN1,"")) I PSODLBD1 D
 ..S PSODLBD3=$P($G(^TMP($J,"PSOPDOSA","OUT","EXCEPTIONS","DOSE",PSODSEQ,PSODLNN1,PSODLBD1)),"^",3) I PSODLBD3 S PSODRUG("BAD",PSODLBD3)=1
 Q
 ;
EXCEPT ;don't show "not matched to NDF" or "no GCNSEQNO" errors for dosing - when dosage is edited enhanced order checks are performed again so we don't want to display these type messages for dosing.
 N PSODLER1,PSODLER2,PSODLER3
 F PSODLER1=0:0 S PSODLER1=$O(^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN1,"EXCEPTIONS",PSODLER1)) Q:'PSODLER1  D
 .S PSODLER2=$G(^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN1,"EXCEPTIONS",PSODLER1))
 .I PSODLER2["Drug not matched to NDF"!(PSODLER2["GCNSEQNO") D
 .. S PSODLER3="" F PSODLER3=PSODLER1-1:1:PSODLER1 K ^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN1,"EXCEPTIONS",PSODLER3)
 Q
 ;
FEED() ; Write Line feed after Exceptions if no message globals follow, and next order has no errors or exceptions, only a message
 I PSODLQT Q 0
 N PSODLNN2
 I $D(^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN1,"MESSAGE")) Q 0
 S PSODLNN2=$O(^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN1))
 I PSODLNN2="" Q 0
 I $D(^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN2,"ERROR")) Q 0
 I $D(^TMP($J,"PSOPDOSN","OUT",PSODSEQ,PSODLNN2,"EXCEPTIONS")) Q 0
 Q 1
 ;
DCHKN ;Called from PSOORNEW, PSOORNE1 & PSOORNEW; Dose Check for Copying an Order
 N PSOGENF
 S PSOGENF=0
 F PSOCPXA=0:0 S PSOCPXA=$O(PSONEW("DOSE",PSOCPXA)) Q:'PSOCPXA  S PSOCPXB=PSOCPXB+1
 D FIN^PSODOSCL(.PSODLBS1,.PSONEW,.PSODRUG)
 S PSODLNVL=$$DOSE^PSODOSUN K ^TMP($J,"PSOPDOSN") K ^TMP($J,"PSOPDOSA")
 I $P($G(PSODLNVL),"^")=1 S PSORX("DFLG")=1 Q
 I '$G(PSODLNVL) Q
 I '$D(^XUSEC("PSORPH",DUZ)) S:$P($G(PSODLNVL),"^") ^TMP("PSODOSF",$J,0)=1 Q
 S PSODLNVT=$P(PSODLNVL,"^",2)
 I +PSODLNVL=3 S PSORX("DFLG")=1 Q
 ;I +PSODLNVL=3 D CANCEL(PSONEW("OIRXN")) Q  ;CR2724
 I +$G(PSOGENF) Q  ;Do not do intervention on a single General Dose message.
 I $$EN3^PSORXI(PSODLNVT) W !!,"Unable to log intervention, cannot find intervention type.",! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
DCHKR ;Renewal Dose Check; Called from PSORENW0
 N PSOGENF
 S PSOGENF=0
 F PSOCPXA=0:0 S PSOCPXA=$O(PSORENW("DOSE",PSOCPXA)) Q:'PSOCPXA  S PSOCPXB=PSOCPXB+1
 D FIN^PSODOSCL(.PSODLBS1,.PSORENW,.PSODRUG)
 S PSODLNVL=$$DOSE^PSODOSUN
 I '$D(^XUSEC("PSORPH",DUZ)) S:$P($G(PSODLNVL),"^") ^TMP("PSODOSF",$J,0)=1
 K ^TMP($J,"PSOPDOSN") K ^TMP($J,"PSOPDOSA") I $P($G(PSODLNVL),"^")=1 S PSORX("DFLG")=1 Q
 D DOSIV
 Q
 ;
DCHKC ;Dose Check on reinstate; Called from PSOCAN2
 N PSODCAN,PSOGENF
 S PSOGENF=0
 I '$D(PSODRUG("IEN")) S:$D(PSORENW("OIRXN")) PSODRUG("IEN")=$$GET1^DIQ(52,PSORENW("OIRXN"),6,"I")
 S PSOCPXB=0 F PSOCPXA=0:0 S PSOCPXA=$O(^PSRX(PSORENW("OIRXN"),6,PSOCPXA)) Q:'PSOCPXA  I $P($G(^PSRX(PSORENW("OIRXN"),6,PSOCPXA,0)),"^")'="" S PSOCPXB=PSOCPXB+1
 D RX^PSODOSCL(.PSODLBS1,PSORENW("OIRXN"))
 S PSODLNNN=PSORENW("OIRXN"),PSODCAN=1
 S PSODLNVL=$$DOSE^PSODOSUN K ^TMP($J,"PSOPDOSN"),^TMP($J,"PSOPDOSA")
 I $P($G(PSODLNVL),"^")=1 S PSORX("DFLG")=1 Q
 D DOSIV
 I +PSODLNVL=3 S PSORX("DFLG")=1
 Q
 ;
DCHK() ;Dose check after entering Null at the conjunction prompt
 ;For complex Dosing, they will eventually enter null too, so change to call if it was not a complex order, and null was entered
 N PSODONOF S PSODONOF="" D DOSEOFF Q:'+PSODONOF 0
 Q:$G(PSORX("DFLG")) 0
 ;D HD:(($Y+5)>IOSL) Q:$G(PSORX("DFLG")) 0
 N PSODLNNN,PSODLENT,PSODLNVL,PSODLNVT,X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,PSODLBS1,PSODLENT,PSOCPXA,PSOCPXV,PSOTOF,PSOCPXB,PSOGENF,PSOEDDOS
 S PSOGENF=0
 I $G(PSOEDIT) S PSOEDDOS=1
 ;Need to make sure Drug Name is what you set in the API
 ;Either pass in name here, or set in PSODOSCL to array name that PSSDSAPD uses, which is still the .01 of File 50
 I $$EXMT^PSSDSAPI(PSODRUG("IEN")) Q 0
 I $G(PSODRUG("BAD",PSODRUG("IEN"))) Q 0
 ;Currently only one prospective drug at a time for Outpatient Dose Check
 ;S PSODLNNN="O;1;PROSPECTIVE;1"
 K ^TMP("PSODOSF",$J)
 K ^TMP($J,"PSOPDOSA") K ^TMP($J,"PSOPDOSN") S PSODLBS1(1)="PSOPDOSA",PSODLBS1(3)="PSOPDOSN"
 D FIN^PSODOSCL(.PSODLBS1,.PSORXED,.PSODRUG)
 S PSODLENT=ENT,PSOCPXV=1,PSOCPXB=0
 S PSOCPXB=0 F PSOCPXA=0:0 S PSOCPXA=$O(PSORXED("DOSE",PSOCPXA)) Q:'PSOCPXA  S PSOCPXB=PSOCPXB+1
 S PSODLNVL=$$DOSEX^PSODOSUN(PSODLENT) S PSOTOF=1 I '$D(^XUSEC("PSORPH",DUZ)) S:$P($G(PSODLNVL),"^") ^TMP("PSODOSF",$J,0)=1
 I $G(PSOEDDOS) D HD:(($Y+5)>IOSL) Q:$G(PSORX("DFLG")) 0
 I $P($G(PSODLNVL),"^")=1 K ^TMP($J,"PSOPDOSA") K ^TMP($J,"PSOPDOSN") Q 1   ;turn of general dosing flag because Intervention is needed
DCHK2 ;Finishing of a complex order
 N PSOCPXC,PSOCPXD
 K PSODLNVL
 S PSOCPXD=1 ;flag for MOCHA 2.0, used to not display enter to continue prompt after errors/exceptions list which displays just after last dose sequence.  MOCHA 2.0 does not display errors or exceptions.
 ;S (PSOCPXB)=0 ;setting PSOCPXB=0 makes dosing summery not display when cycling through individual doses of a complex order.  Dose summary should only show after accept of order.
 S PSODLNVL=$$DOSEZ^PSODOSUN K ^TMP($J,"PSOPDOSA") K ^TMP($J,"PSOPDOSN")
 I $G(PSOEDDOS) D HD:(($Y+5)>IOSL) Q:$G(PSORX("DFLG")) 0
 I $P($G(PSODLNVL),"^")=1 Q 1
 I '$D(^XUSEC("PSORPH",DUZ)) S:$P($G(PSODLNVL),"^")=2 ^TMP("PSODOSF",$J,0)=$$CONVMSG($P(PSODLNVL,"^",2)) W ! Q 0
 I '$G(PSODLNVL) Q 0
 S PSODLNVT=$P(PSODLNVL,"^",2)
 I $D(PSORX("EDIT"))!($G(PSORXED)&$G(PSORXED)&$G(PSOEDDOS))!($G(PSOCOPY)&$G(PSODLBD4)) Q 0
 I +$G(PSOGENF) Q 0  ;Do not do intervention on a single General Dose message.
 I $$EN3^PSORXI(PSODLNVT) W !!,"Unable to log intervention, cannot find intervention type.",! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR
 W !
 Q 0
 ;
DCHK1 ;Dose check after entering a value at the Conjunction prompt
 Q:$G(PSORX("DFLG"))!($G(PSODLQT))
 N PSODONOF S PSODONOF="" D DOSEOFF Q:'+PSODONOF
 ;D HD:(($Y+5)>IOSL) Q:$G(PSORX("DFLG"))
 N PSODLNNN,PSODLNVL,PSODLNVT,X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,PSODLBS1,PSODLENT,PSOCPXB,PSOGENF
 S PSOGENF=0
 ;Need to make sure Drug Name is what you set in the API
 ;Either pass in name here, or set in PSODOSCL to array name that PSSDSAPD uses, which is still the .01 of File 50
 I $$EXMT^PSSDSAPI(PSODRUG("IEN")) Q
 I $G(PSODRUG("BAD",PSODRUG("IEN"))) Q
 ;Currently only one prospective drug at a time for Outpatient Dose Check
 ;S PSODLNNN="O;1;PROSPECTIVE;1"
 K ^TMP($J,"PSOPDOSA") K ^TMP($J,"PSOPDOSN") S PSODLBS1(1)="PSOPDOSA",PSODLBS1(3)="PSOPDOSN"
 D FIN^PSODOSCL(.PSODLBS1,.PSORXED,.PSODRUG)
 S PSODLENT=ENT,PSOCPXB=0
 F PSOCPXA=0:0 S PSOCPXA=$O(PSORXED("DOSE",PSOCPXA)) Q:'PSOCPXA  S PSOCPXB=PSOCPXB+1
 S PSODLNVL=$$DOSEX^PSODOSUN(PSODLENT)
 D HD:(($Y+5)>IOSL) Q:$G(PSORX("DFLG"))
 K ^TMP($J,"PSOPDOSA") K ^TMP($J,"PSOPDOSN") I $P($G(PSODLNVL),"^")=1 S PSORXED("DFLG")=1 Q
 I '$G(PSODLNVL) Q
 I '$D(^XUSEC("PSORPH",DUZ)) S:$P($G(PSODLNVL),"^")=2 ^TMP("PSODOSF",$J,0)=$$CONVMSG($P(PSODLNVL,"^",2)) W ! Q
 S PSODLNVT=$P(PSODLNVL,"^",2)
 I +$G(PSOGENF) Q  ;Do not do intervention on a single General Dose message.
 I $$EN3^PSORXI(PSODLNVT) W !!,"Unable to log intervention, cannot find intervention type.",! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR
 W !
 Q
 ;
CONVMSG(MESS) ;Convert DOSE CHECK message to numeric value for field 8 of ^PS(52.4
 ;For MOCHA 2.0, only returning "DOSAGE EXCEEDS MAX SINGLE DOSE" when a dosing error is present.
 N PSODOSF
 S MESS="DOSAGE EXCEEDS MAX SINGLE DOSE AND/OR MAX DAILY DOSE"
 S PSODOSF=$S(MESS="DOSAGE EXCEEDS MAX SINGLE DOSE AND/OR MAX DAILY DOSE":4,MESS="MAX SINGLE DOSE & MAX DAILY DOSE":3,MESS="MAX SINGLE DOSE":2,MESS="MAX DAILY DOSE":1,1:"")
 Q PSODOSF
 ;
DCHKV ;Dose check when verifying an order
 N PSODOSF,PSOLINE,PSOVERFL,PSOVCAN,PSOGENF
 S PSOVERFL=1
 S PSOGENF=0
 F PSOCPXA=0:0 S PSOCPXA=$O(^PSRX(PSONV,6,PSOCPXA)) Q:'PSOCPXA  I $P($G(^PSRX(PSONV,6,PSOCPXA,0)),"^")'="" S PSOCPXB=PSOCPXB+1
 D RX^PSODOSCL(.PSODLBS1,PSONV)
 S $P(PSOLINE,"-",79)="-"
 S PSODLNNN=PSONV
 S PSODLNVL=$$DOSE^PSODOSUN K ^TMP($J,"PSOPDOSN") K ^TMP($J,"PSOPDOSA") I $P($G(PSODLNVL),"^")=1 S PSORX("DFLG")=1 Q
 I '$D(^XUSEC("PSORPH",DUZ)) S:$P($G(PSODLNVL),"^")=2 ^TMP("PSODOSF",$J,0)=$$CONVMSG($P(PSODLNVL,"^",2))
 I '$G(PSODLNVL) Q
 I +PSODLNVL=3 D  Q:PSOVCAN
 . D SIG^XUSESIG I X1="" S (PSORX("DFLG"),PSVERFLG)=1 Q
 . D NOOR^PSOCAN4
 . I $G(DIRUT) D UPOUT^PSODGDG1,KILL^PSODGDG1 K PSONORR,PSORX("INTERVENE") Q
 . S PSOVCAN=1
 . S DA=PSONV D RXV^PSODGDG1 S DA=PSONV D INV^PSODGDG1 S DA=PSONV D PSDEL^PSODGDG1,DEL^PSODGDG1
 . K DIK,LST,PSONOOR S PSVERFLG=1
 S PSODLNVT=$P(PSODLNVL,"^",2),PSODOSF=1
 I +PSODLNVL=3 S PSORX("DFLG")=1 Q
 S DA=PSONV,RX=$G(^PSRX(PSONV,0)) D DOSIV  ;CRI^PSODGDG1
 Q
 ;
DOSIV ;DOSE INTERVENTION
 I PSOFROM="C",'$D(^XUSEC("PSORPH",DUZ)) Q
 I '$D(^XUSEC("PSORPH",DUZ)) S:$P($G(PSODLNVL),"^")=2 ^TMP("PSODOSF",$J,0)=$$CONVMSG($P(PSODLNVL,"^",2)) Q
 I '$G(PSODLNVL) Q
 S PSODLNVT=$P(PSODLNVL,"^",2)
DOSIV1 ;
 I +$G(PSOGENF) Q  ;Do not do intervention on a single General Dose message.
 I $$EN3^PSORXI(PSODLNVT) D
 . W !!,"Unable to log intervention, cannot find intervention type.",!
 . K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to continue" D ^DIR K DIR
 Q
 ;
CANCEL(PSONV) ;CR2724 -  where PSONV = RXIEN 
 D SIG^XUSESIG I X1="" S PSORX("DFLG")=1 Q
 D NOOR^PSOCAN4
 I $G(DIRUT) D UPOUT^PSODGDG1,KILL^PSODGDG1 K PSONORR,PSORX("INTERVENE") Q
 S DA=PSONV D INV^PSODGDG1 S DA=PSONV D PSDEL^PSODGDG1,DEL^PSODGDG1
 K DIK,LST,PSONOOR
 Q
 ;
DOSCK(PSOFROM,MSG) ;
 ;D HD
 N PSODONOF S PSODONOF="" D DOSEOFF Q:'+PSODONOF
 I $G(PSORX("DFLG"))!($G(PSODOSD)) S PSORX("DFLG")=1 K PSODOSD Q
 N PSODLNNN,PSODLNVL,PSODLNVT,X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,PSODLBS1,PSOCPXA,PSOCPXB,PSOCPXC
 Q:$$EXMT^PSSDSAPI(PSODRUG("IEN"))
 Q:$G(PSODRUG("BAD",PSODRUG("IEN")))
 K ^TMP($J,"PSOPDOSN"),^TMP($J,"PSOPDOSA"),^TMP("PSODOSF",$J) S PSODLBS1(1)="PSOPDOSA",PSODLBS1(3)="PSOPDOSN"
 I ($D(DTOUT))!($D(DUOUT))!($G(DIRUT))!($G(PSODLQT)) K PSODLQT,DTOUT,DUOUT,DIRUT,PSORX("DFLG") Q
 ;D CLEAR^VALM1
 S PSOCPXB=0
 I PSOFROM="V" D DCHKV Q  ;PSOVER1 - verification 
 I PSOFROM="N" D DCHKN Q  ;PSOORNE1 & PSOORNEW - new & copy
 I PSOFROM="R" D DCHKR Q  ;PSORENW0 - renewal
 I PSOFROM="C" D DCHKC Q  ;PSOCAN2 - cancel
 Q
 ;
RCONVMS(MESS) ;Convert DOSE CHECK from numeric to alpha
 N PSODOSF
 S MESS=4  ;For MOCHA 2.0, only returning "DOSAGE EXCEEDS MAX SINGLE DOSE" when a dosing error is present.
 S PSODOSF=$S(MESS=4:"DOSAGE EXCEEDS MAX SINGLE DOSE AND/OR MAX DAILY DOSE",MESS=3:"MAX SINGLE DOSE & DAILY DOSE RANGE",MESS=2:"MAX SINGLE DOSE",MESS=1:"DAILY DOSE RANGE",1:"")
 Q PSODOSF
 ;
DOSEOFF ;
 S PSODONOF=$$DS^PSSDSAPI
DOSEOFF2 ;
 I $G(PSORX("DOSING OFF")),+PSODONOF K PSORX("DOSING OFF"),PSOREINF,PSOONOFC Q
 Q:+PSODONOF
 I ($G(PSOONOFC)!$G(PSOREINF)),'+PSODONOF S PSORX("DOSING OFF")=1  ;Reinstate news PSORX array so have to work around it
 Q:$G(PSORX("DOSING OFF"))  ;only display 'dosing off' message once per patient 
 N PSODOFFC
 I '+PSODONOF&($P(PSODONOF,"^",2)'="") D
 .S X=$P(PSODONOF,"^",2),DIWL=1,DIWR=73 K ^UTILITY($J,"W") D ^DIWP W !
 .S PSODOFFC=0 F PSODOFFC=0:0 S PSODOFFC=$O(^UTILITY($J,"W",DIWL,PSODOFFC)) Q:'PSODOFFC  W !?5,$G(^UTILITY($J,"W",DIWL,PSODOFFC,0))
 .N DIR,DIRUT,DUOUT,X,Y S DIR(0)="E"
 .S DIR("A")="Press Return to continue...",DIR("?")="Press Return to continue"
 .W ! D ^DIR K DIRUT,DUOUT,DIR,X,Y W !
 .K ^UTILITY($J,"W")
 .S PSORX("DOSING OFF")=1 S:$G(PSOREINS) (PSOREINF,PSOONOFC)=1  ;set this flag to only display 'dosing off' message once per session. 
 Q
