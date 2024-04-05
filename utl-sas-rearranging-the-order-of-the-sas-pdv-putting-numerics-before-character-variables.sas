%let pgm=utl-sas-rearranging-the-order-of-the-sas-pdv-putting-numerics-before-character-variables;                             
                                                                                                                               
Rearranging the order of the PDV putting numerics before character variables                                                   
                                                                                                                               
  Two Solutions                                                                                                                
     1. varlist                                                                                                                
     2. merge                                                                                                                  
        Keintz, Mark                                                                                                           
        mkeintz@outlook.com                                                                                                    
                                                                                                                               
inspired by                                                                                                                    
https://goo.gl/B3yGv9                                                                                                          
https://communities.sas.com/t5/Base-SAS-Programming/Sorting-variables-by-type/m-p/337829                                       
                                                                                                                               
varlist                                                                                                                        
Author: Søren Lassen, s.lassen@post.tele.dk                                                                                    
                                                                                                                               
/**************************************************************************************************************************/   
/*                                   |                                                   |                                */   
/*                                   |                                                   |                                */   
/*                 INPUT             |             PROCESS                               |           OUTPUT               */   
/*                 =====             |             =======                               |           ======               */   
/* 1. Varlisr                        |                                                   |                                */   
/*                                   |                                                   |                                */   
/*  SASHELP.CLASS                    |   data class/view=class;                          |      NUMERIC       CHARACTER   */   
/*                                   |    retain                                         | ----------------   ----------- */   
/*  NAME     SEX AGE  HEIGHT  WEIGHT |     %utl_varlist(sashelp.class,keep=_numeric_)    | AGE HEIGHT WEIGHT  NAME    SEX */   
/*                                   |     %utl_varlist(sashelp.class,keep=_character_)  |                                */   
/*  Alfred    M   14   69.0    112.5 |    ;                                              |  14  69.0   112.5  Alfred   M  */   
/*  Alice     F   13   56.5     84.0 |    set sashelp.class;                             |  13  56.5    84.0  Alice    F  */   
/*  Barbara   F   13   65.3     98.0 |   run;quit;                                       |  13  65.3    98.0  Barbara  F  */   
/*  Carol     F   14   62.8    102.5 |                                                   |  14  62.8   102.5  Carol    F  */   
/*  Henry     M   14   63.5    102.5 |                                                   |  14  63.5   102.5  Henry    M  */   
/*  James     M   12   57.3     83.0 |                                                   |                                */   
/*                                   |                                                   |                                */   
/*------------------------------------------------------------------------------------------------------------------------*/   
/*                                   |                                                   |                                */   
/* 2. Merge                          | data want;                                        |      NUMERIC       CHARACTER   */   
/*                                   |                                                   | ----------------   ----------- */   
/*                                   |   merge sashelp.class (keep=_numeric_)            | AGE HEIGHT WEIGHT  NAME    SEX */   
/*                                   |         sashelp.class (keep=_character_);         |                                */   
/*                                   |                                                   |  14  69.0   112.5  Alfred   M  */   
/*                                   | run;                                              |  13  56.5    84.0  Alice    F  */   
/*                                   |                                                   |  13  65.3    98.0  Barbara  F  */   
/*                                   |                                                   |  14  62.8   102.5  Carol    F  */   
/*                                   |                                                   |  14  63.5   102.5  Henry    M  */   
/*                                   |                                                   |                                */   
/**************************************************************************************************************************/   
                                                                                                                               
/*              _                                                                                                              
  ___ _ __   __| |                                                                                                             
 / _ \ `_ \ / _` |                                                                                                             
|  __/ | | | (_| |                                                                                                             
 \___|_| |_|\__,_|                                                                                                             
                                                                                                                               
*/                                                                                                                             
                                                                                                                               






















































data class/view=class;
 retain
  %utl_varlist(sashelp.class,keep=_numeric_)
  %utl_varlist(sashelp.class,keep=_character_)
 ;
 set sashelp.class;
run;quit;


HAVE
====

Up to 40 obs from sashelp.class total obs=19

Obs    NAME       SEX    AGE    HEIGHT    WEIGHT

  1    Alfred      M      14     69.0      112.5
  2    Alice       F      13     56.5       84.0
  3    Barbara     F      13     65.3       98.0
  4    Carol       F      14     62.8      102.5
  5    Henry       M      14     63.5      102.5
  6    James       M      12     57.3       83.0
...

WANT
====

Up to 40 obs from want total obs=19

Obs    AGE    HEIGHT    WEIGHT    NAME       SEX

  1     14     69.0      112.5    Alfred      M
  2     13     56.5       84.0    Alice       F
  3     13     65.3       98.0    Barbara     F
  4     14     62.8      102.5    Carol       F
  5     14     63.5      102.5    Henry       M
  6     12     57.3       83.0    James       M

WORKING CODE
============

    DOSUBL
      array num _numeric_;
      chrs=catx(' ',chrs,vname(chr[i]));
      call symputx("retnum",nums);

      retain &retnum;

FULL SOLUTION
=============

%symdel retnum; * just in case it exists;
data want;

 * get meta data;
 if _n_ =0 then do;

   %let rc=%sysfunc(dosubl('

    data _null_;
      set sashelp.class(obs=1);
      array num _numeric_;
      length nums $4096;
      do i=1 to dim(num);
         nums=catx(' ',nums,vname(num[i]));
      end;
      call symputx("retnum",nums);
    run;quit;

      '));
  end;

    retain &retnum;
    set sashelp.class;

  run;quit;

run;quit;
