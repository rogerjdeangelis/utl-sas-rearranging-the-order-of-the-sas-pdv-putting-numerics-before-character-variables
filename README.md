# utl-sas-rearranging-the-order-of-the-sas-pdv-putting-numerics-before-character-variables
Rearranging the order of the PDV putting numerics before character variables 
    %let pgm=utl-sas-rearranging-the-order-of-the-sas-pdv-putting-numerics-before-character-variables;

    Rearranging the order of the PDV putting numerics before character variables

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
    /*  James     M   12   57.3     83.0 |                                                   |  12  57.3    83.0  James    M  */
    /*                                   |                                                   |                                */
    /**************************************************************************************************************************/

     /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */



