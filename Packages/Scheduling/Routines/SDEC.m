SDEC ;ALB/SAT,PC - VISTA SCHEDULING RPCS ;Feb 12, 2020@15:22
 ;;5.3;Scheduling;**627,643,642,651,658,665,672,679,686,694**;Aug 13, 1993;Build 61
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ;
ACCGROUP(SDECY) ;EP return active entries from the SDEC ACCESS GROUP file 409.822
 D ACCGROUP^SDEC45(.SDECY) Q
ACCGPTYG(SDECY) ;EP Get access group types
 D ACCGPTYG^SDEC15(.SDECY) Q
ACCTYPE(SDECY) ;EP return active entries from the SDEC ACCESS TYPE file 409.823
 D ACCTYPE^SDEC45(.SDECY) Q
ADDACCG(SDECY,SDECVAL) ;EP ADD/EDIT ACCESS GROUP
 D ADDACCG^SDEC21(.SDECY,$G(SDECVAL)) Q
ADDACCTY(SDECY,SDECVAL) ;EP ADD/EDIT ACCESS TYPE
 D ADDACCTY^SDEC14(.SDECY,$G(SDECVAL)) Q
ADDAGI(SDECY,SDECIEN,SDECIEN1) ;EP Add access group item - Adds ACCESS GROUP TYPE file entry
 D ADDAGI^SDEC22(.SDECY,$G(SDECIEN),$G(SDECIEN1)) Q
ADDRES(SDECY,SDECVAL) ;EP ADD/EDIT RESOURCE
 D ADDRES^SDEC16(.SDECY,$G(SDECVAL)) Q
ADDRESU(SDECY,SDECVAL) ;EP ADD/EDIT RESOURCE USER
 D ADDRESU^SDEC18(.SDECY,$G(SDECVAL)) Q
ADDRG(SDECY,SDECVAL) ;EP ADD/EDIT RESOURCE GROUP
 D ADDRG^SDEC19(.SDECY,$G(SDECVAL)) Q
ADDRGI(SDECY,SDECIEN,SDECIEN1) ;EP Adds RESOURCEID SDECIEN1 to RESOURCE GROUP entry SDECIEN
 D ADDRGI^SDEC20(.SDECY,$G(SDECIEN),$G(SDECIEN1)) Q
APBLKALL(SDECY,SDECSTART,SDECEND) ;EP List of all appointments for all resources
 D APBLKALL^SDEC05(.SDECY,$G(SDECSTART),$G(SDECEND)) Q
APBLKOV(SDECY,SDECSTART,SDECEND,SDECRES,SDECWI) ;EP APPT BLOCKS OVERLAP
 D APBLKOV^SDEC05(.SDECY,$G(SDECSTART),$G(SDECEND),$G(SDECRES),$G(SDECWI)) Q
APPADD ;EP ADD NEW APPOINTMENT
 Q  ;rpc calls directly to APPADD^SDEC07
APPDEL(SDECY,SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER) ;EP Cancels appointment
 D APPDEL^SDEC08(.SDECY,$G(SDECAPTID),$G(SDECTYP),$G(SDECCR),$G(SDECNOT),$G(SDECDATE),$G(SDUSER)) Q
APPIDGET(SDECY,SDID) ;GET SDEC APPOINTMENT ien for given External ID
 D APPIDGET^SDEC55(.SDECY,$G(SDID)) Q
APPSDGET(SDECY,MAXREC,LASTSUB,SDBEG,SDEND,NOTEFLG,SDRES,DFN,SDID,SDIEN) ;GET appointment data from SDEC APPOINTMENT file 409.84
 D APPSDGET^SDEC55A(.SDECY,$G(MAXREC),$G(LASTSUB),$G(SDBEG),$G(SDEND),$G(NOTEFLG),$G(SDRES),$G(DFN),$G(SDID),$G(SDIEN)) Q
APPSLOTS(SDECY,SDCL,SDBEG,SDEND) ;return array of appt slots and availability - RPC
 D APPSLOTS^SDEC57(.SDECY,$G(SDCL),$G(SDBEG),$G(SDEND)) Q
APPTLETR(SDECY,SDECAPID,LT) ;EP Print Appointment Letter
 D APPTLETR^SDEC40(.SDECY,$G(SDECAPID),$G(LT)) Q
APPTEVLG(SDECY,DFN) ;EP return appointment data for given patient - RPC
 D APPTEVLG^SDEC38(.SDECY,$G(DFN)) Q
APPTYPES(RET,DFN) ; EP for SDEC APPTYPES - Return all active Appointment types from the APPOINTMENT TYPE file 409.1
 D APPTYPES^SDECWL(.RET,$G(DFN)) Q
ARCLOSE(RET,INP...) ; 
 D ARCLOSE^SDECAR(.RET,.INP) Q
ARCLOSE1(RET,INP) ; Appt Request CLOSE (without ... for VistA calls) ; 
 D ARCLOSE^SDECAR(.RET,.INP) Q
ARDGET(SDECY) ;get values for disposition field of SDEC APPT REQUEST file
 D ARDGET^SDECAR(.SDECY) Q
ARGET(RET,ARIEN1,MAXREC,SDBEG,SDEND,DFN,LASTSUB,SDTOP,SVCL,DESDT,PRL,SVCR,SCVISIT,CLINIC,ORIGDT) ;EP Appt Request GET
 D ARGET^SDECAR1(.RET,$G(ARIEN1),$G(MAXREC),$G(SDBEG),$G(SDEND),$G(DFN),$G(LASTSUB),$G(SDTOP),$G(SVCL),$G(DESDT),$G(PRL),$G(SVCR),$G(SCVISIT),$G(CLINIC),$G(ORIGDT)) Q
ARMRTGET(SDECY,ARIEN) ;GET number of entries and values in MRTC CALC PREF DATES
 D ARMRTGET^SDECAR(.SDECY,$G(ARIEN)) Q
ARMRTSET(SDECY,ARIEN,MRTC) ;SET MRTC CALC PREF DATES dates - clears the multiple and sets the new ones that are passed in
 D ARMRTSET^SDECAR(.SDECY,$G(ARIEN),$G(MRTC)) Q
AROPEN(RET,ARAPP,ARIEN,ARDDT) ;Appt Request Open/re-open
 D AROPEN^SDECAR(.RET,$G(ARAPP),$G(ARIEN),$G(ARDDT)) Q
ARPCSET(SDECY,INP,ARIEN) ;SET update patient contacts in SDEC APPT REQUEST file
 D ARPCSET^SDECAR(.SDECY,$G(INP),$G(ARIEN)) Q
ARSET(RET,INP...) ;EP Appt Request Set ;
 D ARSET^SDECAR2(.RET,.INP) Q
ARSET1(RET,INP) ;EP Appt Request Set (without ... for VistA calls)
 D ARSET^SDECAR2(.RET,.INP) Q
AVADD(SDECY,SDECSTART,SDECEND,SDECTYPID,SDECRES,SDECSLOTS,SDECNOTE) ;EP SET Create entry in SDEC ACCESS BLOCK
 D AVADD^SDEC12(.SDECY,$G(SDECSTART),$G(SDECEND),$G(SDECTYPID),$G(SDECRES),$G(SDECSLOTS),$G(SDECNOTE)) Q
AVDEL(SDECY,SDECAVID) ;EP Cancel Availability - Deletes Access Block
 D AVDEL^SDEC13(.SDECY,$G(SDECAVID)) Q
AVDELDT(SDECY,SDECRESD,SDECSTART,SDECEND) ;EP Cancel availability in a date range
 D AVDELDT^SDEC13(.SDECY,$G(SDECRESD),$G(SDECSTART),$G(SDECEND)) Q
BOOKHLDY(SDECY,SDECCL) ; Returns can book on holiday flag for a clinic. 12/1/17 wtc 679 
 D BOOKHLDY^SDEC32(.SDECY,SDECCL) Q  ;
CANCKOUT(SDECY,SDECAPTID) ;EP Cancel Check Out appointment
 D CANCKOUT^SDEC25(.SDECY,$G(SDECAPTID)) Q
CANREAS(SDECY,SDECIN) ;EP return active/inactive entries from the CANCELLATION REASONS table 409.2
 D CANREAS^SDEC45(.SDECY,$G(SDECIN)) Q
CAP(SDECY,DFN,SDAMEVT,SDT,DVBADA,SDAUTORB,SDCANVET) ;
 D CAP^SDEC58(.SDECY,$G(DFN),$G(SDAMEVT),$G(SDT),$G(DVBADA),$G(SDAUTORB),$G(SDCANVET)) Q
CGET(SDECY) ;GET active Countries from the COUNTRY CODE file 779.004
 D CGET^SDEC55(.SDECY) Q
CHECKIN(SDECY,SDECAPTID,SDECCDT,SDECCC,SDECPRV,SDECROU,SDECVCL,SDECVFM,SDECOG,SDECCR,SDECPCC,SDECWHF) ;EP Check in appointment
 D CHECKIN^SDEC25(.SDECY,$G(SDECAPTID),$G(SDECCDT),$G(SDECCC),$G(SDECPRV),$G(SDECROU),$G(SDECVCL),$G(SDECVFM),$G(SDECOG),$G(SDECCR),$G(SDECPCC),$G(SDECWHF)) Q
CHECKOUT(SDECY,DFN,SDT,SDCODT,SDECAPTID,VPRV) ;EP Check Out appointment
 D CHECKOUT^SDEC25(.SDECY,$G(DFN),$G(SDT),$G(SDCODT),$G(SDECAPTID),$G(VPRV)) Q
CLINALL(RET,MAXREC,SDECP) ; EP Return the IEN and NAME for all entries in the SD WL CLINIC LOCATION file
 D CLINALL^SDECWL(.RET,$G(MAXREC),$G(SDECP)) Q
CLINCAN(SDECY,SDECCLST,SDECBEG,SDECEND) ;EP Return recordset of CANCELLED patient appointments
 D CLINCAN^SDEC34(.SDECY,$G(SDECCLST),$G(SDECBEG),$G(SDECEND)) Q
CLINDIS(SDECY,SDECCLST,SDECBEG,SDECEND,SDECWI) ;EP Return formatted text output of the Clinic Schedules Report
 D CLINDIS^SDEC47(.SDECY,$G(SDECCLST),$G(SDECBEG),$G(SDECEND),$G(SDECWI)) Q
CLINDISW(SDECY,SDECCLST,SDECBEG,SDECEND) ;EP Return formatted text output of the Clinic Schedules Report for Walkins
 D CLINDISW^SDEC47(.SDECY,$G(SDECCLST),$G(SDECBEG),$G(SDECEND)) Q
CLINLET(SDECY,SDECCLST,SDECBEG,SDECEND,SDECWI) ;EP CLINIC LETTERS Appointment data
 D CLINLET^SDEC27(.SDECY,$G(SDECCLST),$G(SDECBEG),$G(SDECEND),$G(SDECWI)) Q
CLINLETW(SDECY,SDECCLST,SDECBEG,SDECEND) ;EP CLINIC LETTERS WALK-IN Appointment data for Walk-in Appointments only
 D CLINLETW^SDEC27(.SDECY,$G(SDECCLST),$G(SDECBEG),$G(SDECEND)) Q
CLINPROV(SDECY,SDECCL) ;EP return all providers for a given clinic from the HOSPITAL LOCATION file 44
 D CLINPROV^SDEC45(.SDECY,$G(SDECCL)) Q
CLINSET(SDECY,SDNOSLOT,SDIENS,SDECP,SDNOLET,MAXREC) ;EP Returns CLINIC SETUP PARAMETERS for clinics that are active in the HOSPITAL LOCATION file
 D CLINSET^SDEC32(.SDECY,$G(SDNOSLOT),$G(SDIENS),$G(SDECP),$G(SDNOLET),$G(MAXREC)) Q
CLINSTOP(SDECY,SDP) ;EP CLINIC STOP remote procedure
 D CLINSTOP^SDEC45(.SDECY,$G(SDP)) Q
COPYAPPT(SDECY,SDECRES,SDEC44,SDECBEG,SDECEND) ;EP Copy appointments from HOSPITAL LOCATION to SDEC RESOURCE
 D COPYAPPT^SDEC29(.SDECY,$G(SDECRES),$G(SDEC44),$G(SDECBEG),$G(SDECEND)) Q
CPCANC(SDECY,SDECTSK) ;EP Copy Appointment Cancel
 D CPCANC^SDEC29(.SDECY,$G(SDECTSK)) Q
CPSTAT(SDECY,SDECTSK) ;EP Copy Appointment Status
 D CPSTAT^SDEC29(.SDECY,$G(SDECTSK)) Q
CRSCHED(SDECY,SDECRES,SDECSTART,SDECEND,SDECWKIN,MAXREC,LASTSUB) ;EP Create Resource Appointment Schedule ;alb/sat 672
 D CRSCHED^SDEC02(.SDECY,$G(SDECRES),$G(SDECSTART),$G(SDECEND),$G(SDECWKIN),$G(MAXREC),$G(LASTSUB)) Q
CSLOTSCH(SDECY,SDECRES,SDECSTART,SDECEND,SDECTYPES,SDECSRCH) ;GET Create Assigned Slot Schedule
 D CSLOTSCH^SDEC04(.SDECY,$G(SDECRES),$G(SDECSTART),$G(SDECEND),$G(SDECTYPES),$G(SDECSRCH)) Q
CURFACG(SDECY,SDECDUZ) ;EP get current division/facility for given user
 D CURFACG^SDEC46(.SDECY,$G(SDECDUZ)) Q
CVARAPPT(SDECY,SDCL) ;EP IS Clinic Variable Appointment Length
 D CVARAPPT^SDEC37(.SDECY,$G(SDCL)) Q
DELAG(SDECY,SDECGRP) ;EP Deletes entry having IEN SDECGRP from SDEC ACCESS GROUP file
 D DELAG^SDEC21(.SDECY,$G(SDECGRP)) Q
DELAGI(SDECY,SDECIEN,SDECIEN1) ;EP Deletes entry having Access Group SDECIEN and Access Type SDECIEN1 the SDEC ACCESS GROUP TYPE file
 D DELAGI^SDEC22(.SDECY,$G(SDECIEN),$G(SDECIEN1)) Q
DELRESGP(SDECY,SDECGRP) ;EP Deletes entry name SDECGRP from SDEC RESOURCE GROUP file
 D DELRESGP^SDEC19(.SDECY,$G(SDECGRP)) Q
DELRGI(SDECY,SDECIEN,SDECIEN1) ;EP Deletes entry SDECIEN1 from entry SDECIEN in the SDEC RESOURCE GROUP file
 D DELRGI^SDEC20(.SDECY,$G(SDECIEN),$G(SDECIEN1)) Q
DELRU(SDECY,SDECIEN) ;EP Delete Resource User from SDEC RESOURCE USER file
 D DELRU^SDEC18(.SDECY,$G(SDECIEN)) Q
EDITAPPT(SDECY,SDECAPTID,SDECNOTE,SDECLEN) ;EP Edit appointment (only 'note text' and appointment length can be edited)
 D EDITAPPT^SDEC26(.SDECY,$G(SDECAPTID),$G(SDECNOTE),$G(SDECLEN)) Q
EHRPT(SDECY,SDECWID,SDECDFN) ;EP Raise patient selection event to EHR
 D EHRPT^SDEC30(.SDECY,$G(SDECWID),$G(SDECDFN)) Q
ETHGET(SDECY) ;GET active Ethnicities from the ETHNICITY file 10.2
 D ETHGET^SDEC55(.SDECY) Q
ETHCMGET(SDECY) ;GET values from the RACE AND ETHNICITY COLLECTION METHOD file 10.3
 D ETHCMGET^SDEC55(.SDECY) Q
FACLIST(SDECY,DFN) ; Return list of remote facilities for patient
 D PTINQ^SDECPT(.SDECY,$G(DFN)) Q
FAPPTGET(SDECY,DFN,SDBEG,SDEND,SDANC) ;GET Future appointments for given patient and date range
 D FAPPTGET^SDEC50(.SDECY,$G(DFN),$G(SDBEG),$G(SDEND),$G(SDANC)) Q
GETFAC(SDECY,SDECDUZ) ;EP Gets all facilities for a user
 D GETFAC^SDEC46(.SDECY,$G(SDECDUZ)) Q
GETONE(SDECY,SDGMR) ;EP Return data on one consult
 D GETONE^SDEC51(.SDECY,$G(SDGMR)) Q
GETREGA(SDECRET,DFN) ;EP return basic reg info/demographics for given patient
 D GETREGA^SDEC09(.SDECRET,$G(DFN)) Q
GETSITES(SDECY) ;return active National VA site names and station numbers
 D GETSITES^SDEC59(.SDECY) Q
GETVPRV(BGOY,VPRV) ;EP return data from the V PROVIDER file
 D GETVPRV^SDEC44(.BGOY,$G(VPRV)) Q
HIDE(SDECY) ;Return clinics hidden from display
 D HIDE^SDEC45(.SDECY) Q
HOLIDAY(SDECY,SDECBD) ;EP return all entries from the HOLIDAY file 40.5
 D HOLIDAY^SDEC45(.SDECY,$G(SDECBD)) Q
HOSPLOC(SDECY,SDECP,MAXREC,LSUB) ;EP return HOSPITAL LOCATIONs
 D HOSPLOC^SDEC32(.SDECY,$G(SDECP),$G(MAXREC),$G(LSUB)) Q
IMHERE(SDECRES) ;EP I'm Here
 D IMHERE^SDEC31(.SDECRES) Q
NETLOC(SDECY,LOCATION) ;GET data from the NETWORK LOCATION file 2005.2
 D NETLOC^SDEC59(.SDECY,$G(LOCATION)) Q
NEWPERS(SDECY,SDCLASS,SDPART,MAXREC,LSUB,INACT) ;return entries from the USR CLASS MEMBERSHIP file that have the given USR CLASS (default is PROVIDER)
 D NEWPERS^SDEC45(.SDECY,$G(SDCLASS),$G(SDPART),$G(MAXREC),$G(LSUB),$G(INACT)) Q
NOSHOPAT(SDECY,DFN,SDCL) ;EP COLLECT NO-SHOW DATA for Patient
 D NOSHOPAT^SDEC37(.SDECY,$G(DFN),$G(SDCL)) Q
NOSHOW(SDECY,SDECAPTID,SDECNS,USERIEN,SDECDATE) ;EP Sets appointment noshow flag in SDEC APPOINTMENT file
 D NOSHOW^SDEC31(.SDECY,$G(SDECAPTID),$G(SDECNS),$G(USERIEN),$G(SDECDATE)) Q
OVBOOK(SDECY,SDCL,SDBEG,SDECRES) ;EP RPC - OVERBOOK - CHECK FOR OVERBOOK FOR GIVEN CLINIC, DATE, AND RESOURCE
 D OVBOOK^SDEC07A(.SDECY,$G(SDCL),$G(SDBEG),$G(SDECRES)) Q
PATAPPTD(SDECY,DFN) ;EP Return the Patient appointment display
 D PATAPPTD^SDEC27(.SDECY,$G(DFN)) Q
PATAPPTH(SDECY,DFN) ;EP return patient's appointment history for given patient - RPC
 D PATAPPTH^SDEC48(.SDECY,$G(DFN)) Q
PCSGET(SDECY,SDSVSP) ;GET clinics for a service/specialty (clinic stop)
 D PCSGET^SDEC50(.SDECY,$G(SDSVSP)) Q
PCSTGET(SDECY,DFN,SDCL,SDBEG,SDEND) ;GET patient clinic status for a clinic for a given time frame - has the patient been seen by the given Clinic in the past 24 months
 D PCSTGET^SDEC50(.SDECY,$G(DFN),$G(SDCL),$G(SDBEG),$G(SDEND)) Q
PCST2GET(SDECY,DFN,STOP,SDBEG,SDEND) ;GET patient clinic status for a service/specialty (clinic stop) for a given time frame - has the patient been seen any clinics with the given service/specialty (clinic stop) in the past 24 months
 D PCST2GET^SDEC50(.SDECY,$G(DFN),$G(STOP),$G(SDBEG),$G(SDEND)) Q
PREFGET(SDECY,DFN,INAC) ;EP Get values from SDEC PREFERENCES AND SPECIAL NEEDS file for given patient
 D PREFGET^SDEC49(.SDECY,$G(DFN),$G(INAC)) Q
PREFGETV(SDECY) ;EP Get all valid PREFERENCE text from SDEC PREFERENCES AND SPECIAL NEEDS file
 D PREFGETV^SDEC49(.SDECY) Q
PREFSET(SDECY,DFN,PREF,REMARK) ;EP Set values to SDEC PREFERENCES AND SPECIAL NEEDS file ;alb/sat 658 add REMARK
 D PREFSET^SDEC49(.SDECY,$G(DFN),$G(PREF),$G(REMARK)) Q
PRIV(SDECY,CLINIEN,USER) ;IS this USER in the PRIVILEGED USER multiple for the clinic
 D PRIV^SDEC32(.SDECY,$G(CLINIEN),$G(USER)) Q
PROVALL(SDECY,SDECCL) ;EP return all providers for a given clinic from the HOSPITAL LOCATION file 44
 D PROVALL^SDEC45(.SDECY,$G(SDECCL)) Q
PROVCLIN(SDECY,SDECPRV) ;EP PROVIDER CLINICS remote procedure
 D PROVCLIN^SDEC45(.SDECY,$G(SDECPRV)) Q
PTINQ(SDECY,DFN) ;GET output from ORWPT PTINQ in DataTable format
 D PTINQ^SDECPT(.SDECY,$G(DFN)) Q
PTLOOKRS(SDECY,SDECP,SDECC,LASTSUB) ;EP Patient Lookup
 D PTLOOKRS^SDEC28(.SDECY,$G(SDECP),$G(SDECC),$G(LASTSUB)) Q
PTSET(SDECY,INP...) ;SET patient demographics
 D PTSET^SDEC53(.SDECY,.INP) Q
PTSET1(SDECY,INP) ;SET patient demographics (call from debug)
 D PTSET^SDEC53(.SDECY,.INP) Q
RACEGET(SDECY) ;GET active Race entries from the RACE file 10
 D RACEGET^SDEC55(.SDECY) Q
RAISEVNT(SDECY,SDECEVENT,SDECPARAM,SDECSIP,SDECSPT) ;EP RAISE EVENT
 D RAISEVNT^SDEC23(.SDECY,$G(SDECEVENT),$G(SDECPARAM),$G(SDECSIP),$G(SDECSPT)) Q
REBKCLIN(SDECY,SDECCLST,SDECBEG,SDECEND) ;EP Return recordset of rebooked patient appointments between given dates
 D REBKCLIN^SDEC34(.SDECY,$G(SDECCLST),$G(SDECBEG),$G(SDECEND)) Q
REBKLIST(SDECY,SDECLIST) ;EP patient appointments used in listing REBOOKED appointments for a list of appointmentIDs.
 D REBKLIST^SDEC34(.SDECY,$G(SDECLIST)) Q
REBKNEXT(SDECY,SDECDATE,SDECRES,SDECTPID) ;EP find the next ACCESS BLOCK in resource SDECRES after SDECSTART
 D REBKNEXT^SDEC33(.SDECY,$G(SDECDATE),$G(SDECRES),$G(SDECTPID)) Q
RECIEN(SDECY,RECIEN) ;GET RECALL REMINDERS for given ID
 D RECIEN^SDEC52(.SDECY,$G(RECIEN)) Q
RECGET(SDECY,DFN,SDBEG,SDEND,MAXREC,LASTSUB,RECIEN,SDSTOP,SDFLAGS,SDCLL) ; GET entries from the RECALL REMINDERS file 403.5 for a given Patient and Recall Date range. ;alb/sat 658 add SDCLL
 D RECGET^SDEC52(.SDECY,$G(DFN),$G(SDBEG),$G(SDEND),$G(MAXREC),$G(LASTSUB),$G(RECIEN),$G(SDSTOP),$G(SDFLAGS),$G(SDCLL)) Q
RECSET(SDECY,INP...) ; SET/EDIT/CANCEL/DELETE an entry to the RECALL REMINDERS file 403.5
 D RECSET^SDEC52A(.SDECY,.INP) Q
RECSET1(SDECY,INP) ; SET/EDIT/CANCEL/DELETE an entry to the RECALL REMINDERS file 403.5
 D RECSET^SDEC52A(.SDECY,.INP) Q
RECDSET(SDECY,RECALLIEN,SDRRFTR,SDCOMM) ; DELETE an entry to the RECALL REMINDERS file 403.5
 D RECDSET^SDEC52A(.SDECY,$G(RECALLIEN),$G(SDRRFTR),$G(SDCOMM)) Q
RECAPGET(SDECY) ; GET entries from the RECALL REMINDERS APPT TYPE file 403.51
 D RECAPGET^SDEC52B(.SDECY) Q
RECPRGET(SDECY,RECINACT,SDECP,MAXREC,LASTSUB) ;GET entries from the RECALL REMINDERS PROVIDERS file 403.54
 D RECPRGET^SDEC52B(.SDECY,$G(RECINACT),$G(SDECP),$G(MAXREC),$G(LASTSUB)) Q
REGEVENT(SDECY,SDECEVENT,SDECIP,SDECPORT) ;EP Called by client to inform server of client's interest in SDECEVENT
 D REGEVENT^SDEC23(.SDECY,$G(SDECEVENT),$G(SDECIP),$G(SDECPORT)) Q
REP1GET(SDECY,MAXREC,LASTSUB,PNAME) ;GET clinic data for report
 D REP1GET^SDEC56(.SDECY,$G(MAXREC),$G(LASTSUB),$G(PNAME)) Q
REQGET(SDECY,SDBEG,SDEND,MAXREC,LASTSUB,SDGMR) ; GET entries with an ACTIVITY of RECEIVED, but do not have an ACTIVITY of SCHEDULED from the REQUEST/CONSULTATING file 123
 D REQGET^SDEC51(.SDECY,$G(SDBEG),$G(SDEND),$G(MAXREC),$G(LASTSUB),$G(SDGMR)) Q
RESGPUSR(SDECY,SDECDUZ) ;EP GROUP RESOURCE
 D RESGPUSR^SDEC01(.SDECY,$G(SDECDUZ)) Q
RESGRPUS(SDECY,SDECDUZ) ;EP return ACTIVE resource group names for the given user
 D RESGRPUS^SDEC01(.SDECY,$G(SDECDUZ)) Q
RESLETRF(SDECY,SDECRES,SDECLT) ;EP Return formatted text output of the Resource's Letter - either "LETTER TEXT" (also used as Reminder Letter), NO SHOW LETTER, or CLINIC CANCELLATION LETTER.
 D RESLETRF^SDEC47(.SDECY,$G(SDECRES),$G(SDECLT)) Q
RESLETRS(SDECY,SDECLIST,SDLTR,SDNOS,SDCAN) ;EP GET recordset of RESOURCES and associated LETTERS
 D RESLETRS^SDEC35(.SDECY,$G(SDECLIST),$G(SDLTR),$G(SDNOS),$G(SDCAN)) Q
RESUSER(SDECY,SDRES) ;EP SDEC RESOURCE USER remote procedure returns all entries from the SDEC RESOURCE USER table 409.833
 D RESUSER^SDEC45(.SDECY,$G(SDRES)) Q
RESOURCE(SDECY,SDECDUZ,SDACT,SDTYPE,MAXREC,LASTSUBI,SDIEN,SDECP) ;EP Returns ADO Recordset with ALL RESOURCE names
 D RESOURCE^SDEC01A(.SDECY,$G(SDECDUZ),$G(SDACT),$G(SDTYPE),$G(MAXREC),$G(LASTSUBI),$G(SDIEN),$G(SDECP)) Q
SCHUSR(SDECY) ;EP Return recordset of all users in NEW PERSON having SDECZMENU key
 D SCHUSR^SDEC17(.SDECY) Q
SEARCHAV(SDECY,SDECRES,SDECSTRT,SDECEND,SDECTYPES,SDECAMPM,SDECWKDY) ;EP Searches availability database
 D SEARCHAV^SDEC24(.SDECY,$G(SDECRES),$G(SDECSTRT),$G(SDECEND),$G(SDECTYPES),$G(SDECAMPM),$G(SDECWKDY)) Q
SETFAC(SDECY,SDECDUZ,SDECFAC) ;EP SET FACILITY
 D SETFAC^SDEC46(.SDECY,$G(SDECDUZ),$G(SDECFAC)) Q
SETRBOOK(SDECY,SDECAPPT,SDECDATE) ;EP Sets rebook date into appointment
 D SETRBOOK^SDEC33(.SDECY,$G(SDECAPPT),$G(SDECDATE)) Q
SPACEBAR(SDECY,SDECDIC,SDECVAL) ;EP Update ^DISV with most recent lookup value SDECVAL from file SDECDIC
 D SPACEBAR^SDEC30(.SDECY,$G(SDECDIC),$G(SDECVAL)) Q
SUMMGET(SDECRET,SDBEG,SDEND,USER,LSUB,MAXREC) ;GET Audit Summary for given date range
 D SUMMGET^SDEC54(.SDECRET,$G(SDBEG),$G(SDEND),$G(USER),$G(LSUB),$G(MAXREC)) Q
SUMMGET2(SDECRET,SDBEG,SDEND,USER) ;Get compiled Audit Report for a given date range
 D SUMMGET2^SDECAUD(.SDECRET,$G(SDBEG),$G(SDEND),$G(USER)) Q
SUMMAGET(SDECY,SDBEG,SDEND,USER,LSUB,MAXREC) ;get ALL appointments with a cancel status from SDEC APPOINTMENT for given date range and user
 D SUMMAGET^SDEC54A(.SDECY,$G(SDBEG),$G(SDEND),$G(USER),$G(LSUB),$G(MAXREC)) Q
SUSRINFO(SDECY,SDECDUZ,GUIVERS) ;EP SCHEDULING USER INFO
 ;
 ; Added GUI version to parameters to prevent users from using old versions. SD*5.3*694 wtc 8/27/2018
 ;
 D SUSRINFO^SDEC01(.SDECY,$G(SDECDUZ),$G(GUIVERS)) Q
SVSPALL(RET) ; EP return IEN and NAME for all entries in the SD WL SERVICE/SPECIALTY file
 D SVSPALL^SDECWL(.RET) Q
SYSSTAT(SDECY) ; EP SYSTEM STATUS
 D SYSSTAT^SDECUTL(.SDECY) Q
TPBLKOV(SDECY,SDECSTART,SDECEND,SDECRES) ;EP TYPE BLOCKS OVERLAP
 D TPBLKOV^SDEC06(.SDECY,$G(SDECSTART),$G(SDECEND),$G(SDECRES)) Q
UNDOCANA(SDECY,SDECAPTID) ;EP Undo Cancel Appointment
 D UNDOCANA^SDEC08(.SDECY,$G(SDECAPTID)) Q
UNREGEV(SDECY,SDECEVENT,SDECIP,SDECPORT) ;EP rpc SDE UNREGEV Called by client to Unregister client's interest in SDECEVENT
 D UNREGEV^SDEC23(.SDECY,$G(SDECEVENT),$G(SDECIP),$G(SDECPORT)) Q
WAITLIST(SDECY,SDECRES) ;EP COLLECT WAITLIST DATA
 D WAITLIST^SDEC36(.SDECY,$G(SDECRES)) Q
WLCLOSE(RET,INP...) ; Waitlist CLOSE
 D WLCLOSE^SDECWL(.RET,.INP) Q
WLCLOSE1(RET,INP) ; Waitlist CLOSE (without ... for VistA calls)
 D WLCLOSE^SDECWL(.RET,.INP) Q
WLGET(RET,WLIEN1,MAXREC,SDBEG,SDEND,DFN,LASTSUB,SDTOP,SVCL,DESDT,PRI,SVCR,SCVISIT,CLINIC,ORIGDT) ;EP Waitlist GET ;alb/sat 658 add SVCL-SCVISIT
 D WLGET^SDECWL1(.RET,$G(WLIEN1),$G(MAXREC),$G(SDBEG),$G(SDEND),$G(DFN),$G(LASTSUB),$G(SDTOP),$G(SVCL),$G(DESDT),$G(PRI),$G(SVCR),$G(SCVISIT),$G(CLINIC),$G(ORIGDT)) Q
WLHIDE(SDECY,DFN,WLCL) ;GET wait list entries in which the associated clinic's 'HIDE FROM DISPLAY?' field is 'YES'
 D WLHIDE^SDECWL3(.SDECY,$G(DFN),$G(WLCL)) Q
WLOPEN(RET,WLAPP,WLIEN,WLDDT) ;SET Waitlist Open/re-open
 D WLOPEN^SDECWL(.RET,$G(WLAPP),$G(WLIEN),$G(WLDDT)) Q
WLPCSET(SDECY,INP,WLIEN) ;SET update patient contacts in SD WAIT LIST file
 D WLPCSET^SDECWL(.SDECY,$G(INP),$G(WLIEN)) Q
WLSET(RET,INP...) ;EP Waitlist Set
 D WLSET^SDECWL2(.RET,.INP) Q
WLSET1(RET,INP) ;EP Waitlist Set (without ... for VistA calls)
 D WLSET^SDECWL2(.RET,.INP) Q
