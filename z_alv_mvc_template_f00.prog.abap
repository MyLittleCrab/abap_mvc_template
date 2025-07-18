CLASS lcl_mvc_model IMPLEMENTATION.
  "! <p class="shorttext synchronized" lang="en">Constructor for MVC Model</p>
  "! Initializes the model and loads initial data
  METHOD constructor.
*    do something
    init_data( ).
  ENDMETHOD.                    "constructor

  "! <p class="shorttext synchronized" lang="en">Get row by index from ALV table</p>
  "! Retrieves a specific row from the internal ALV table by its index
  "! @parameter iv_index | Index of the row to retrieve
  "! @parameter rs_row | Table row structure containing the requested data
  METHOD get_row_by_index.
    READ TABLE gt_alv INDEX iv_index INTO rs_row.
  ENDMETHOD.                    "get_row_by_index

  "! <p class="shorttext synchronized" lang="en">Initialize data for ALV display</p>
  "! Loads data from TVARVC table into the internal ALV table
  METHOD init_data.
    CLEAR gt_alv.

    SELECT * FROM tvarvc INTO TABLE gt_alv.
  ENDMETHOD.                    "init_data

ENDCLASS.                    "lcl_mvc_model IMPLEMENTATION
