PXCASC ;SLC/PKR - PCE Device Interface for V STANDARD CODES ;09/08/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 325
 Q
 ;
VALID(PXCA,PXCABULD,PXCAERRS) ;Validation routine for V STANDARD CODES.
 N CODE,CODESYS,CODESYSL,IND,NSC,PXCAPRV,SCDT,TEMP
 D CODESYSL^PXLEX(.CODESYSL,0)
 S NSC=0,PXCAPRV=""
 F  S PXCAPRV=$O(PXCA("STD CODES",PXCAPRV)) Q:PXCAPRV=""  D
 . S IND=0
 . F  S IND=$O(PXCA("STD CODES",PXCAPRV,IND)) Q:IND']""  D
 .. S TEMP=$G(PXCA("STD CODES",PXCAPRV,IND,12))
 ..;If the Event Date and Time is present use it.
 .. S SCDT=$P(TEMP,U,1)
 .. I SCDT="" S SCDT=$S($G(PXCAVSIT)'="":$$CSDATE^PXDXUTL(PXCAVSIT),$D(PXCADT)=1:PXCADT,1:DT)
 .. I PXCAPRV>0 D
 ... I '$$ACTIVPRV^PXAPI(PXCAPRV,SCDT)  S PXCA("ERROR","STD CODES",PXCAPRV,0,0)="Provider is not active or valid for the date "_$$FMTE^XLFDT(SCDT)_"^"_PXCAPRV
 ... E  I PXCABULD!PXCAERRS D ANOTHPRV^PXCAPRV(PXCAPRV)
 .. S TEMP=$G(PXCA("STD CODES",PXCAPRV,IND))
 .. I TEMP="" S PXCA("ERROR","STD CODES",PXCAPRV,IND,0)="STD CODES data missing." Q
 .. S NSC=NSC+1
 .. S CODE=$P(TEMP,U,1)
 .. I CODE="" S PXCA("ERROR","STD CODES",PXCAPRV,IND,1)="The code is missing."
 .. S CODESYS=$P(TEMP,U,5)
 .. I CODESYS="" S PXCA("ERROR","STD CODES",PXCAPRV,IND,2)="The coding system is missing."
 .. I '$D(CODESYSL(CODESYS)) S PXCA("ERROR","STD CODES",PXCAPRV,IND,3)="The coding system "_CODESYS_" is not supported for V STANDARD CODES."
 .. I '$$VCODE^PXLEX(CODESYS,CODE) S PXCA("ERROR","STD CODES",PXCAPRV,IND,4)="The coding system "_CODESYS_" and code "_CODE_" pair is not valid."
 ..;Is the code active on the date?
 .. I '$$ISCACT^PXLEX(CODESYS,CODE,SCDT) S PXCA("ERROR","STD CODES",PXCAPRV,IND,5)="The code "_CODE_" is inactive on "_$$FMTE^XLFDT(SCDT,5)_"."
 Q
 ;
