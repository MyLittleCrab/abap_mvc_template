CLASS lcl_mvc_controller IMPLEMENTATION.
  "! <p class="shorttext synchronized" lang="en">Constructor for MVC Controller</p>
  "! Initializes the controller object
  METHOD constructor.

  ENDMETHOD.                    "constructor

  "! <p class="shorttext synchronized" lang="en">Run the MVC application</p>
  "! Creates model and view instances and starts the ALV display
  METHOD run.
    CREATE OBJECT go_model.
    CREATE OBJECT go_view
      EXPORTING
        io_model      = go_model
        io_controller = me.

    go_view->display( CHANGING ct_alv = go_model->gt_alv ).
  ENDMETHOD.                    "run

  "! <p class="shorttext synchronized" lang="en">Handle select all action</p>
  "! Selects all checkboxes in the ALV table and refreshes the display
  METHOD handle_select.
    FIELD-SYMBOLS <ls_alv> TYPE ts_alv.
    LOOP AT go_model->gt_alv ASSIGNING <ls_alv>.
      <ls_alv>-checkbx = abap_true.
    ENDLOOP.
    go_view->refresh( ).
  ENDMETHOD.                    "handle_select

  "! <p class="shorttext synchronized" lang="en">Handle deselect all action</p>
  "! Deselects all checkboxes in the ALV table and refreshes the display
  METHOD handle_deselect.
    FIELD-SYMBOLS <ls_alv> TYPE ts_alv.
    LOOP AT go_model->gt_alv ASSIGNING <ls_alv>.
      <ls_alv>-checkbx = abap_false.
    ENDLOOP.
    go_view->refresh( ).
  ENDMETHOD.                    "handle_deselect

  "! <p class="shorttext synchronized" lang="en">Handle double-click event on ALV</p>
  "! Processes double-click events on different columns and shows appropriate messages
  "! @parameter e_row | Row information of the double-clicked cell
  "! @parameter e_column | Column information of the double-clicked cell
  "! @parameter es_row_no | Row number information
  METHOD handle_double_click.
    DATA: lv_current_row TYPE ts_alv,
          lv_message     TYPE string.
    lv_current_row = go_model->get_row_by_index( e_row-index ).

    CASE e_column-fieldname.
      WHEN 'NAME'.
        CONCATENATE 'double click on name ' lv_current_row-name INTO lv_message.
        go_view->info_message( lv_message ).
      WHEN 'TYPE'.
        CONCATENATE 'double click on type ' lv_current_row-name INTO lv_message.
        go_view->info_message( lv_message ).
      WHEN 'LOW'.
        CONCATENATE 'double click on value ' lv_current_row-name INTO lv_message.
        go_view->info_message( lv_message ).
    ENDCASE.
  ENDMETHOD.                    "handle_double_click

ENDCLASS.                    "lcl_mvc_controller IMPLEMENTATION
