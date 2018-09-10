KPL/FK

Schiaparelli Entry, Descent and Landing Demonstrator Module (EDM) Frames Kernel
===============================================================================

   This frame kernel contains a complete set of frame definitions for the
   ExoMars-16 Schiaparelli Entry, Descent and Landing Demonstrator Module 
   (EDM) including definitions for the EDM structures and EDM science 
   instrument frames. This kernel also contains NAIF ID/name mapping for 
   the EDM instruments.


Version and Date
------------------------------------------------------------------------

   Version 0.0 -- August 05, 2016 -- Marc Costa Sitja, ESAC/ESA

      Preliminary Version. Only EDM Name to NAIF ID mappings and basic
      frame definitions. This version is based on the latest InSight 
      Frame Definitions Kernel (insight_v01.tf).


References
------------------------------------------------------------------------

    1. ``Frames Required Reading'', NAIF 

    2. ``Kernel Pool Required Reading'', NAIF 

    3. ``C-Kernel Required Reading'', NAIF
   
    4. ``ExoMars System User Manual'', 
       EXM-MS-MAN-AI-0005, 2016-02-19, Thales Alenia Space.

    5. ``EXOMARS OMB frame definitions and conventions'', 
       EXM-OM-TNO-AF-0361, Issue 3, 2011-10-14, Thales Alenia Space.

    6. ``EXOMARS EDL DEMONSTRATOR MODULE (EDM) design report, 
       EXM-DM-DRP-AI-0022, Issue 5, 2015-09-15, Thales Alenia Space.
      

Contact Information
------------------------------------------------------------------------

   If you have any questions regarding this file contact SPICE support at
   ESAC:

           Marc Costa Sitja
           (+34) 91-8131-457
           mcosta@sciops.esa.int, esa_spice@sciops.esa.int
           
   or SPICE support at IKI:
   
           Anton Ledkov
           +7 (495) 333-12-66
           aledkov@rssi.ru
           
   or NAIF at JPL:
   
           Boris Semenov
           (818) 354-8136
           Boris.Semenov@jpl.nasa.gov
      
     
Implementation Notes
------------------------------------------------------------------------

   This file is used by the SPICE system as follows: programs that make
   use of this frame kernel must "load" the kernel normally during 
   program initialization. Loading the kernel associates the data items 
   with their names in a data structure called the "kernel pool". The 
   routine that loads a kernel into the pool is shown below:
                                                                               
      FORTRAN: (SPICELIB)

         CALL FURNSH ( frame_kernel_name )

      C: (CSPICE)

         furnsh_c ( frame_kernel_name );

      IDL: (ICY)

         cspice_furnsh, frame_kernel_name
         
      MATLAB: (MICE)
      
         cspice_furnsh ( 'frame_kernel_name' )

   This file was created and may be updated with a text editor or word
   processor.

   
EDM NAIF ID Codes -- Summary Section
------------------------------------------------------------------------

   The following names and NAIF ID codes are assigned to the EDM spacecraft,
   its structures and science instruments (the keywords implementing these
   definitions are located in the section "EDM NAIF ID Codes -- Definition
   Section" at the end of this file):
   
   EDM Spacecraft and Spacecraft Structures names/IDs:

            EDM                      -117     (synonyms: EXOMARS 2016 EDM
            EDM_LANDING_SITE         -117900   and EDL DEMONSTRATOR MODULE)
            EDM_LANDER               -117000

   AMELIA names/IDs:
   
            EDM_AMELIA               -117100

   COMARS names/IDs:
   
            EDM_COMARS               -117200

   DECA names/IDs:
   
            EDM_DECA                 -117500
   
   DREAMS names/IDs:
    
            EDM_DREAMS               -117300
            
   INRRI names/IDs:
   
            EDM_INRRI                -117400


EDM Lander Frames
------------------------------------------------------------------------

   The following EDM frames are defined in this kernel file:

           Name                  Relative to           Type      NAIF ID
      ======================  ===================  ============  =======

   Lander frames (-11700x):
   ------------------------
      EDM_LANDER_CRUISE          J2000                CK         -117001 
      EDM_LANDER                 EDM_LANDER_CRUISE,   CK         -117000
                                 EDM_LANDED_LOCAL                    

   Surface/descent frames (-1179xx):
   ---------------------------------
      EDM_TOPO                   IAU_MARS             FIXED      -117900
      EDM_SURFACE_FIXED          EDM_TOPO             FIXED      -117901
      EDM_LANDED_LOCAL           EDM_TOPO             FIXED      -117902

   AMELIA frames:
   --------------
      EDM_AMELIA_BASE            EDM_LANDER           FIXED      -117100

   COMARS frames:
   --------------
      EDM_COMARS_BASE            EDM_LANDER           FIXED      -117200
 
   DECA frames:
   -------------
      EDM_DECA_BASE              EDM_LANDER           FIXED      -117200
   
   DREAMS frames:
   -------------
      EDM_DREAMS_BASE            EDM_LANDER           FIXED      -117300
      
   INRRI frames:
   -------------
      EDM_INRRI_BASE             EDM_LANDER           FIXED      -117200


ExoMars-2016 Frames Hierarchy
--------------------------------------------------------------------------

   The diagram below shows the ExoMars-2016 frames hierarchy (except
   for science operations frames):


                               "J2000" INERTIAL
           +-----------------------------------------------------+
           |                         |                           |
           |<-pck                    |<-pck                      |<-ck
           |                         |                           |
           v                         v                           |
       "IAU_EARTH"               "IAU_MARS"                      v
    EARTH BODY-FIXED           MARS BODY-FIXED         "TGO_SPACECRAFT"
    ----------------      +-----------------------+    ----------------
                          |                                   |
                          |<--fixed                           |
                          |                                   |
                          v                                   |       
                      "EDM_TOPO"                              |            
                    +------------+                            |                
                    |            |                            |              
                    |     fixed->|                            |              
                    |            |                            |              
             fixed->|            v                            |              
                    |     "EDM_SURFACE_FIXED"                 |                         
                    |     -------------------                 |<-fixed                          
                    |                                         | 
                    v                                         v 
            "EDM_LOCAL_LANDED"                     "EDM_LANDER_CRUISE"         
            ------------------                     ------------------     
                    |                                    | 
                    |<-ck(*)                             |<-ck(*)        
                    |                                    |          
                    v             "EDM_LANDER"           v                       
              +------------------------------------------------+
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      .            
                                      V
                Individual instrument frame trees are provided
                      in the other sections of this file
   
   (*)      In these cases transformation is fixed but it has to be
            stored in a CK to make SPICE "traverse" appropriate frame
            tree branch based on the time of interest and/or loaded
            kernels.   


Implementation of Frame Chains for Different Mission Phases
-------------------------------------------------------------------------------

   Different routes along the branches of the EDM frame hierarchy
   are implemented for different mission phases depending on the
   availability of the orientation data and the source, format and type
   of the data.

   This subsection summarizes mission phase specific implementations.


Cruise
------


     "J2000" Inertial
     ----------------
            |
            | <----------- CK segment containing TLM quaternions or AEM data
            |
            v
     "TGO_SPACECRAFT"
     ----------------
            |
            | <----------- Fixed rotation based on frame definitions 
            |
            V
    "EDM_LANDER_CRUISE"
    -------------------
            |
            | <----------- CK segment representing fixed rotation defined
            |              by the lander design and to make SPICE "transverse"
            V              to the appropiate frame chain
      "EDM_LANDER"
      ------------


Entry-Descent-Landing
---------------------


     "J2000" Inertial
     ----------------
            |
            | <----------- PCK-based transformation
            V
        "IAU_MARS" 
        ----------
            |
            | <----------- Fixed rotation based on frame definitions
            |
            V
    "EDM_LANDER_CRUISE"
    -------------------
            |
            | <----------- CK segment representing fixed rotation defined
            |              by the lander design and to make SPICE "transverse"
            V              to the appropiate frame chain
       "EDM_LANDER"
       ------------


Surface Operations
------------------

   During surface operations the lander orientation is available from
   the following source(s):

      -  initial orientation is provided by the spacecraft team in the
         form of quaternion defining orientation of the EDM_LANDER
         frame with respect to the EDM_LANDED_LOCAL frame;

   To accommodate this(ese) source(s) the following frame chain(s) can
   be implemented:

   Chain 1 (based on spacecraft team quaternion):


     "J2000" Inertial
     ----------------
            |
            | <----------- PCK-based transformation
            V
        "IAU_MARS" 
        ----------
            |
            | <----------- Fixed rotation based on the landing site
            |              coordinates
            V
        "EDM_TOPO"
        ----------
            |
            | <----------- Fixed rotation based on frame definitions
            V
     "EDM_LANDED_LOCAL"
     ------------------
            |
            | <----------- CK segment representing fixed rotation per
            |              initial quaternion and to make SPICE "transverse"
            V              to the appropiate frame chain.
       "EDM_LANDER"
       ------------


EDM Lander Frames
------------------------------------------------------------------------

   This section of the file contains the definitions of the spacecraft
   and spacecraft structures frames.


EDM Lander Cruise Frame
-----------------------

   According to [4] the EDM lander reference frame -- EDM_LANDER_CRUISE
   is defined as follows:

      -  +X axis is parallel to the the revolution axis of the conical 
         shape pointing positively to the Front Shield nose (same
         orientation and direction as +Xsc in the TGO_SPACECRAFT frame 
         when EDM is stowed on the OB);

      -  +Y axis is parallel to the plane of back shell base, pointing 
         positively to the EDM anchorage mechanism located on the HEPA 
         filter side. When EDM is stowed on the OB, +Yedm shall have the 
         same orientation and direction as +Ysc;

      -  +Z axis completes the right-handed frame.

      -  The origin of this frame is the vertex of the EDM upper cone


EDM Lander Frame
----------------

   According to [4] the EDM Surface Platform reference frame -- EDM_LANDER
   is defined as follows:

      -  +X axis is parallel to the the revolution axis of the conical 
         shape pointing positively to the Front Shield nose (same
         orientation and direction as +Xlnd in the EDM_LANDER_CRUISE 
         frame);

      -  +Y axis is parallel to the plane of back shell base, pointing 
         positively to the EDM anchorage mechanism located on the HEPA 
         filter side. +Ylnd is parallel to +Ylnd_cru;

      -  +Z axis completes the right-handed frame.

      -  The origin of this frame is in-plane with the upper face of 
         the Surface Platform.


   These diagrams illustrate the EDM_LANDER_CRUISE and the EDM_LANDER frames:


   +Y EDM full lander (Hepa filter side) view:
   -------------------------------------------

                                       Parachute
                             __....---....__   
      EDM Back Shell       .'---------------'.     
                         .'-.     _____     .-'.             
                       .' .'     /     \     '. '.                       
                     .' .'      /       \      '. '.                     
                   .' .'       '         '       '. '.                   
                 .'--'          `-------'          '--'.                 
               .'                                       '.               
             .'                     __                    '.             
           .'                      /  \ Hepa Filter         '.          
         .'                        \__/                       '.    
       .'                                                       '.  
     .'                            +Ylnd                          '.     
    /_______________________<-------o_______________________________\
   (                    +Zlnd       |                                )
    \_                              |                              _/
      ''--.__                       |                       __.--''    
             ''--.__                v +Xlnd          __.--''            
                    ''--.__   +Ylnd_cru       __.--''                   
                           '<-------o_....--''           +Ysc              
                      +Zlnd_cru     |              <-------o    
                                    |            +Zsc      |        
      EDM Front Shield              |                      | 
                                    v                      | 
                                     +Xlnd_cru             v +Xsc


   -X EDM surface platform side view:
   ----------------------------------
                                     
                            __...--""--....__        
                    _    _''                 ''_    _
                   (/\.-'                       '-./\)
                  _ \/                             \/ _
                 (/\/         ___          _        \/\)
                _ \/  .-''-. O___O  +Ylnd (_).-''-.  \/ _ 
               (/\/  /      \       ^       /      \  \/\)
                \/  |        |      |      |        |  \/   
                :    \      /       |       \      /    :
                |     `-..-'        |        `-..-'     |
                |          ___      x-------> +Zlnd     |  
                ;         /   \  +Xlnd      .-''-.      ;
                 \       |     |           /      \    /
                  \       \___/  .-''-.   |        |  /
                   \            /      \   \      /  /
                    .          |        |   `-..-' .'     
                     '.         \      /         .'       
                       ',_       `-..-'       _,'        
                          ''--....____....--''                                  
                               |_| |_| |_|
                               (_) (_) (_)
   

   -Y EDM surface platform side view:
   ----------------------------------   
                                           __
                           _               \/
                            \|___O         ||     
                    .-''-.    ||  .-''-.   ||  .-''-.  
                  _/      \___||_/___+Ylnd_|| /      \_   
                /||       |     |/\  x---------->     ||\ 
               /.---------------|  ||| ||  |-----+Zlnd--.\
              /_|               |__|||_||__|            |_\                       
                |____________________|__________________|
                          \    \  .-'|-.  /     /           
                           '--._\/___|__\/__.--'                  
                                     |      
                                     V +Xlnd 
                                                                 
Lander Frame Definitions
------------------------

   Both lander frames are defined as CK frames for the following
   reasons:

      -  during cruise and descent the s/c "flies" using the 
         EDM_LANDER_CRUISE frame; the orientation of this frame is 
         determined on-board with respect to the J2000 frame; this 
         orientation is sent down in the chanellized telemetry, from 
         which it is extracted and stored in the cruise CK file;

      -  after landing the initial orientation of the EDM_LANDER_CRUISE
         frame is determined with respect the Landed Local Vertical, 
         Local Horizontal frame (EDM_LANDED_LOCAL); it is stored in 
         the surface orientation CK file(s);

      -  after landing the orientation of the EDM_LANDER frame may
         be determined with respect the local level or topocentric
         frame; this orientation is stored in the surface orientation
         CK file(s);

      -  for different periods (cruise, descent, surface ops) the
         EDM_LANDER frame can be specified as offset to the
         EDM_LANDER_CRUISE frame or the LL frame depending on for
         which of these the orientation data is available.

   Also, should the landed orientation change during surface operations
   due to the arm or other activities, the change in orientation will
   be captured in the landed CK file(s).

   These sets of keywords define the EDM_LANDER_CRUISE frame:

   \begindata

      FRAME_EDM_LANDER                 = -117000
      FRAME_-117000_NAME               = 'EDM_LANDER'
      FRAME_-117000_CLASS              =  3
      FRAME_-117000_CLASS_ID           = -117000
      FRAME_-117000_CENTER             = -117
      CK_-117000_SCLK                  = -117
      CK_-117000_SPK                   = -117
      OBJECT_-117_FRAME                = 'EDM_LANDER'

      FRAME_EDM_LANDER_CRUISE          = -117001
      FRAME_-117001_NAME               = 'EDM_LANDER_CRUISE'
      FRAME_-117001_CLASS              =  3
      FRAME_-117001_CLASS_ID           = -117001
      FRAME_-117001_CENTER             = -117
      CK_-117001_SCLK                  = -117
      CK_-117001_SPK                   = -117
      OBJECT_-117_FRAME                = 'EDM_LANDER_CRUISE'

   \begintext


EDM Surface/descent frames
------------------------------------------------------------------------

EDM Topocentric Frame
---------------------

   This frame defines the z axis as the normal outward at the landing
   site, the x axis points at local north with the y axis completing
   the right handed frame (points at local west.)

   Orientation of the frame is given relative to the body fixed
   rotating frame 'IAU_MARS' (x - along the line of zero longitude
   intersecting the equator, z - along the spin axis, y - completing
   the right hand coordinate frame.)
 
   The transformation from 'EDM_TOPO' frame to 'IAU_MARS' frame is
   a 3-2-3 rotation with defined angles as the negative of the site
   longitude, the negative of the site colatitude, 180 degrees.

   This frame is currently defined for the target landing site 
   EDL-LS1mod in the Meridiani area as defined in [6].
 
   The landing site longitude and latitude upon which the definition 
   is built are:

      Lon = 6.15 degrees West
      Lat = 1.82 degrees South
 
   The coordinates specified above are given with respect to the
   'IAU_MARS' instance defined by the rotation/shape model from the 
   PCK file 'pck00010.tpc'.
 
   These keywords implement the frame definition.

   \begindata

       FRAME_EDM_TOPO               = -117900
       FRAME_-117900_NAME           = 'EDM_TOPO'
       FRAME_-117900_CLASS          =  4
       FRAME_-117900_CLASS_ID       =  -117900
       FRAME_-117900_CENTER         =  -117900

       TKFRAME_-117900_RELATIVE     = 'IAU_MARS'
       TKFRAME_-117900_SPEC         = 'ANGLES'
       TKFRAME_-117900_UNITS        = 'DEGREES'
       TKFRAME_-117900_AXES         = ( 3, 2, 3 )
       TKFRAME_-117900_ANGLES       = ( 6.15, -91.82, 180.000  )

   \begintext


EDM Surface Fixed Frame
-------------------------------------------------------------------------------

   The orientation of the SURFACE_FIXED frame is by definition the same
   as of the EDM_TOPO frame. Therefore this frame is defined as a zero
   offset frame relative to the EDM_TOPO frame.

   \begindata
  
      FRAME_EDM_SURFACE_FIXED      =  -117901
      FRAME_-117901_NAME           = 'EDM_SURFACE_FIXED'
      FRAME_-117901_CLASS          =  4
      FRAME_-117901_CLASS_ID       =  -117901
      FRAME_-117901_CENTER         =  -117

      TKFRAME_-117901_RELATIVE     = 'EDM_TOPO'
      TKFRAME_-117901_SPEC         = 'ANGLES'
      TKFRAME_-117901_UNITS        = 'DEGREES'
      TKFRAME_-117901_AXES         = ( 1,      2,      3     )
      TKFRAME_-117901_ANGLES       = ( 0.000,  0.000,  0.000 )

   \begintext


EDM Landed Local Vertical, Local Horizontal (LANDED_LOCAL) Frame
-------------------------------------------------------------------------------

   This frame is the frame with respect to which the landed lander
   orientation is determined by the on-board attitude.

   The axes of this frame point as follows:

      - +Z axis points along local gravity vector 

      - +X axis points towards local North

      - +Y axis completes the right-hand frame (and, thus points towards
        local East)

   In this file the EDM_LANDED_LOCAL frame is defined as a fixed offset 
   frame with respect to the EDM_TOPO frame that is based on the
   planetographic latitude.

   \begindata

      FRAME_EDM_LANDED_LOCAL       =  -117903
      FRAME_-117903_NAME           = 'EDM_LANDED_LOCAL'
      FRAME_-117903_CLASS          =  4
      FRAME_-117903_CLASS_ID       =  -117903
      FRAME_-117903_CENTER         =  -117

      TKFRAME_-117903_RELATIVE     = 'EDM_TOPO'
      TKFRAME_-117903_SPEC         = 'ANGLES'
      TKFRAME_-117903_UNITS        = 'DEGREES'
      TKFRAME_-117903_AXES         = (   1,      2,      3     )
      TKFRAME_-117903_ANGLES       = ( 180.000,  0.000,  0.000 )

   \begintext
   

EDM NAIF ID Codes -- Definitions
===============================================================================

   This section contains name to NAIF ID mappings for the ExoMars-16 EDM 
   mission. Once the contents of this file is loaded into the KERNEL POOL, 
   these mappings become available within SPICE, making it possible to use 
   names instead of ID code in the high level SPICE routine calls.

  \begindata

      NAIF_BODY_NAME += ( 'EDL DEMONSTRATOR MODULE'     )
      NAIF_BODY_CODE += ( -117                          )

      NAIF_BODY_NAME += ( 'EDM'                         )
      NAIF_BODY_CODE += ( -117                          )
      
      NAIF_BODY_NAME += ( 'EXOMARS 2016 EDM'            )
      NAIF_BODY_CODE += ( -117                          )

      NAIF_BODY_NAME += ( 'EDM_LANDER'                  )      
      NAIF_BODY_CODE += ( -117000                       )

      NAIF_BODY_NAME += ( 'EDM_LANDING_SITE'            )      
      NAIF_BODY_CODE += ( -117900                       )
      

      NAIF_BODY_NAME += ( 'EDM_AMELIA'                  )      
      NAIF_BODY_CODE += ( -117100                       )
      
      NAIF_BODY_NAME += ( 'EDM_COMARS'                  )      
      NAIF_BODY_CODE += ( -117200                       )
      
      NAIF_BODY_NAME += ( 'EDM_DECA'                    )      
      NAIF_BODY_CODE += ( -117500                       )

      NAIF_BODY_NAME += ( 'EDM_DREAMS'                  )      
      NAIF_BODY_CODE += ( -117300                       )
      
      NAIF_BODY_NAME += ( 'EDM_INRRI'                   )      
      NAIF_BODY_CODE += ( -117400                       )

  \begintext
  
