DGPTXX6 ; COMPILED XREF FOR FILE #45.0535 ; 06/24/20
 ; 
 S DA=0
A1 ;
 I $D(DIKILL) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGPT(DA(1),535,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGPT(DA(1),535,DA,0))
 S X=$P($G(DIKZ(0)),U,2)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .K DIV S DIV=X,D0=DA(1),DIV(0)=D0,D1=DA,DIV(1)=D1 S Y(1)=$S($D(^DGPT(D0,535,D1,0)):^(0),1:"") S X=$P(Y(1),U,16),X=X S DIU=X K Y S X="" X ^DD(45.0535,2,1,1,2.4)
 S DIKZ(0)=$G(^DGPT(DA(1),535,DA,0))
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" K ^DGPT(DA(1),535,"ADC",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,10)
 I X'="" K ^DGPT(DA(1),535,"AM",$E(X,1,30),DA)
 G:'$D(DIKLM) A Q:$D(DIKILL)
END G ^DGPTXX7
