DGPTXX14 ; COMPILED XREF FOR FILE #45.06 ; 06/24/20
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:DIKM1=1 DIKLM=1 G @DIKM1
0 ;
A S DA=$O(^DGPT(DA(1),"C",DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^DGPT(DA(1),"C",DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^DGPT(DA(1),"C","B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,6)
 I X'="" D ADD^AUPNVSIT
CR1 S DIXR=624
 K X
 S X(1)=$P(DIKZ(0),U,1)
 S X(2)=$P(DIKZ(0),U,7)
 S X(3)=$P(DIKZ(0),U,9)
 S X=$G(X(1))
 D
 . K X1,X2 M X1=X,X2=X
 . N DIKXARR M DIKXARR=X S DIKCOND=1
 . S X='X2(2)&'X2(3)&X2(1)
 . S DIKCOND=$G(X) K X M X=DIKXARR
 . Q:'DIKCOND
 . S ^DGPT("AB",X2(1),DA(1),DA)=""
CR2 K X
 G:'$D(DIKLM) A Q:$D(DISET)
END Q
