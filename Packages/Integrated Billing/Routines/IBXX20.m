IBXX20 ; COMPILED XREF FOR FILE #399.0222 ; 05/01/19
 ; 
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,112,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=$$BPP^IBCNS2(DA,1) X ^DD(399,112,1,3,1.4)
 S X=$P($G(DIKZ("M")),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X=DIV S X=$$AUTH^IBCNS4(D0,X) S DIH=$G(^DGCR(399,DIV(0),"U")),DIV=X S $P(^("U"),U,13)=DIV,DIH=399,DIG=163 D ^DICR
 S X=$P($G(DIKZ("M")),U,12)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"UF32")):^("UF32"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X=DIV S X=$$REF^IBCNS4(D0,X) X ^DD(399,112,1,5,1.4)
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M")):^("M"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y X ^DD(399,113,1,1,1.1) X ^DD(399,113,1,1,1.4)
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D IX^IBCNS2(DA,"I2")
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,113,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=$$BPP^IBCNS2(DA,1) X ^DD(399,113,1,3,1.4)
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X=DIV S X=$$AUTH^IBCNS4(D0,X) S DIH=$G(^DGCR(399,DIV(0),"U2")),DIV=X S $P(^("U2"),U,8)=DIV,DIH=399,DIG=230 D ^DICR
 S X=$P($G(DIKZ("M")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"UF32")):^("UF32"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=$$REF^IBCNS4(D0,X) X ^DD(399,113,1,5,1.4)
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"M")):^("M"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y X ^DD(399,114,1,1,1.1) X ^DD(399,114,1,1,1.4)
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D IX^IBCNS2(DA,"I3")
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,114,1,3,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=$$BPP^IBCNS2(DA) X ^DD(399,114,1,3,1.4)
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,9),X=X S DIU=X K Y S X=DIV S X=$$AUTH^IBCNS4(D0,X) S DIH=$G(^DGCR(399,DIV(0),"U2")),DIV=X S $P(^("U2"),U,9)=DIV,DIH=399,DIG=231 D ^DICR
 S X=$P($G(DIKZ("M")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"UF32")):^("UF32"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X=$$REF^IBCNS4(D0,X) X ^DD(399,114,1,5,1.4)
 S DIKZ("MP")=$G(^DGCR(399,DA,"MP"))
 S X=$P($G(DIKZ("MP")),U,1)
 I X'="" D MAILA^IBCU5
 S X=$P($G(DIKZ("MP")),U,1)
 I X'="" S DGRVRCAL=1
 S X=$P($G(DIKZ("MP")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$WNRBILL^IBEFUNC(DA) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y X ^DD(399,136,1,1,1.1) X ^DD(399,136,1,1,1.4)
 S DIKZ("M2")=$G(^DGCR(399,DA,"M2"))
 S X=$P($G(DIKZ("M2")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,140,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=$$ACIDD^IBCU(DA,1,X) X ^DD(399,140,1,1,1.4)
 S DIKZ("M2")=$G(^DGCR(399,DA,"M2"))
 S X=$P($G(DIKZ("M2")),U,3)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,142,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV S X=$$ACIDD^IBCU(DA,2,X) X ^DD(399,142,1,1,1.4)
 S DIKZ("M2")=$G(^DGCR(399,DA,"M2"))
 S X=$P($G(DIKZ("M2")),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,144,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"M2")):^("M2"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV S X=$$ACIDD^IBCU(DA,3,X) X ^DD(399,144,1,1,1.4)
 S DIKZ("U")=$G(^DGCR(399,DA,"U"))
 S X=$P($G(DIKZ("U")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I $P(^DGCR(399,DA,0),U,5)<3 I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X=DIV S X=$$LOS1^IBCU64(DA) X ^DD(399,151,1,1,1.4)
 S X=$P($G(DIKZ("U")),U,1)
 I X'="" S DGRVRCAL=1
 S X=$P($G(DIKZ("U")),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I +$G(^DGCR(399,DA,"U1"))=0 I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X=DIV S X=0 X ^DD(399,151,1,3,1.4)
 S X=$P($G(DIKZ("U")),U,1)
 I X'="" S:$P(^DGCR(399,DA,0),"^",2) ^DGCR(399,"APDS",$P(^(0),U,2),-X,DA)=""
 S DIKZ("U")=$G(^DGCR(399,DA,"U"))
 S X=$P($G(DIKZ("U")),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X I $P(^DGCR(399,DA,0),U,5)<3 I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,15),X=X S DIU=X K Y S X=DIV S X=$$LOS1^IBCU64(DA) X ^DD(399,152,1,1,1.4)
 S X=$P($G(DIKZ("U")),U,2)
 I X'="" S DGRVRCAL=1
 S DIKZ("U")=$G(^DGCR(399,DA,"U"))
 S X=$P($G(DIKZ("U")),U,11)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,161,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X=DIV D DIS^IBCU S X=X S DIH=$G(^DGCR(399,DIV(0),"U")),DIV=X S $P(^("U"),U,12)=DIV,DIH=399,DIG=162 D ^DICR
 S DIKZ("U")=$G(^DGCR(399,DA,"U"))
 S X=$P($G(DIKZ("U")),U,15)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=($P($G(^DGCR(399,DA,"U2")),U,2)=""&$$INPAT^IBCEF(DA,1)) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIV X ^DD(399,165,1,1,1.4)
 S X=$P($G(DIKZ("U")),U,15)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .X ^DD(399,165,1,2,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV N Z S X=$$LOS1^IBCU64(DA,.Z),X=+$G(Z) X ^DD(399,165,1,2,1.4)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU+DIV X ^DD(399,218,1,1,1.4)
 S X=$P($G(DIKZ("U2")),U,4)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="PRIOR PAYMENT(S)" X ^DD(399,218,1,2,1.4)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU+DIV X ^DD(399,219,1,1,1.4)
 S X=$P($G(DIKZ("U2")),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="PRIOR PAYMENT(S)" X ^DD(399,219,1,2,1.4)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,6)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU+DIV X ^DD(399,220,1,1,1.4)
 S X=$P($G(DIKZ("U2")),U,6)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="PRIOR PAYMENT(S)" X ^DD(399,220,1,2,1.4)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X=$P($G(DIKZ("U2")),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y X ^DD(399,232,1,1,1.1) X ^DD(399,232,1,1,1.4)
 S X=$P($G(DIKZ("U2")),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$$CLIAREQ^IBCEP8A(DA) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U2")):^("U2"),1:"") S X=$P(Y(1),U,13),X=X S DIU=X K Y S X=DIV S X=$$CLIA^IBCEP8A(DA) X ^DD(399,232,1,3,1.4)
 S X=$P($G(DIKZ("U2")),U,10)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U3")):^("U3"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X=$P($$TAXGET^IBCEP81(X),U,2) X ^DD(399,232,1,4,1.4)
 S DIKZ("M1")=$G(^DGCR(399,DA,"M1"))
 S X=$P($G(DIKZ("M1")),U,8)
 I X'="" S ^DGCR(399,"AG",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ("M1")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV N %I,%H,% D NOW^%DTC S X=% X ^DD(399,471,1,1,1.4)
 S X=$P($G(DIKZ("M1")),U,13)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,4),X=X S DIU=X K Y S X=DIV S X=$S(($D(DUZ)#2):DUZ,1:"") X ^DD(399,471,1,2,1.4)
 S DIKZ("M1")=$G(^DGCR(399,DA,"M1"))
 S X=$P($G(DIKZ("M1")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X=DIV N %I,%H,% D NOW^%DTC S X=% X ^DD(399,472,1,1,1.4)
 S X=$P($G(DIKZ("M1")),U,14)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X=DIV S X=$S(($D(DUZ)#2):DUZ,1:"") X ^DD(399,472,1,2,1.4)
 S DIKZ("M1")=$G(^DGCR(399,DA,"M1"))
 S X=$P($G(DIKZ("M1")),U,15)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,7),X=X S DIU=X K Y S X=DIV N %I,%H,% D NOW^%DTC S X=% X ^DD(399,473,1,1,1.4)
 S X=$P($G(DIKZ("M1")),U,15)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X=DIV S X=$S(($D(DUZ)#2):DUZ,1:"") X ^DD(399,473,1,2,1.4)
 S DIKZ("MP")=$G(^DGCR(399,DA,"MP"))
 S X=$P($G(DIKZ("MP")),U,3)
 I X'="" S ^DGCR(399,"E",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ("MP")),U,5)
 I X'="" S ^DGCR(399,"F",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ("MP")),U,7)
 I X'="" S ^DGCR(399,"G",$E(X,1,30),DA)=""
CR1 S DIXR=139
 K X
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X(1)=$P(DIKZ("M"),U,1)
 S X(2)=$P(DIKZ("M"),U,2)
 S X(3)=$P(DIKZ("M"),U,3)
 S X(4)=$P(DIKZ("M"),U,13)
 S X(5)=$P(DIKZ("M"),U,12)
 S X(6)=$P(DIKZ("M"),U,14)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . N DIKXARR M DIKXARR=X S DIKCOND=1
 . S X=$S($O(^DGCR(399,DA,"PRV",0)):1,1:0)
 . S DIKCOND=$G(X) K X M X=DIKXARR
 . Q:'DIKCOND
 . D:X1(1)'=X2(1)!(X1(5)'=X2(5)) SETID^IBCEP3(DA,1) D:X1(2)'=X2(2)!(X1(4)'=X2(4)) SETID^IBCEP3(DA,2) D:X1(3)'=X2(3)!(X1(6)'=X2(6)) SETID^IBCEP3(DA,3)
CR2 S DIXR=477
 K X
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X(1)=$P(DIKZ("M"),U,1)
 S X(2)=$P(DIKZ("M"),U,2)
 S X(3)=$P(DIKZ("M"),U,3)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(4)=$P(DIKZ(0),U,2)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . N CURR S CURR=+$$COBN^IBCEF(DA) I $G(X(4)),$G(X(CURR)) S ^DGCR(399,"AE",X(4),X(CURR),DA)=""
CR3 S DIXR=820
 K X
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(1)=$P(DIKZ(0),U,22)
 S DIKZ("U2")=$G(^DGCR(399,DA,"U2"))
 S X(2)=$P(DIKZ("U2"),U,10)
 S DIKZ("MP")=$G(^DGCR(399,DA,"MP"))
 S X(3)=$P(DIKZ("MP"),U,2)
 S X(4)=$P(DIKZ(0),U,19)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . D TAX^IBCEF79(DA)
CR4 S DIXR=984
 K X
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(1)=$P(DIKZ(0),U,19)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . N IBLNPRV I $$LNPRVFT^IBCEU7(X,.IBLNPRV) D FILE^DIE("E","IBLNPRV") Q
CR5 S DIXR=985
 K X
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(1)=$P(DIKZ(0),U,19)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . N DIKXARR M DIKXARR=X S DIKCOND=1
 . S X=X(1)=3
 . S DIKCOND=$G(X) K X M X=DIKXARR
 . Q:'DIKCOND
 . D REMOVE^IBCEU7(DA,X(1))
CR6 S DIXR=989
 K X
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X(1)=$P(DIKZ(0),U,27)
 S X=$G(X(1))
 I $G(X(1))]"" D
 . K X1,X2 M X1=X,X2=X
 . D CMAEDALL^IBCU9(DA)
CR7 K X
END G ^IBXX21
