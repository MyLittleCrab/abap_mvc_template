CLASS lcl_mvc_view IMPLEMENTATION.

  "! <p class="shorttext synchronized" lang="en">Constructor for MVC View</p>
  "! Initializes the view with model and controller references, creates container and ALV grid
  "! @parameter io_model | Reference to the model object
  "! @parameter io_controller | Reference to the controller object
  METHOD constructor.
    go_model = io_model.
    go_controller = io_controller.

*    Main container
    CREATE OBJECT go_container
      EXPORTING
        container_name = cv_contname
        repid          = sy-repid
        dynnr          = '100'.

*    ALV
    CREATE OBJECT go_table
      EXPORTING
        i_parent = go_container.

  ENDMETHOD.                    "constructor

  "! <p class="shorttext synchronized" lang="en">Display ALV grid with data</p>
  "! Sets up field catalog, layout, handlers and displays the ALV table
  "! @parameter ct_alv | ALV table data to be displayed
  METHOD display.
*    automatic generation fcat
    init_fcat( ct_alv ).
*    update fcat by your business logic
    update_fcat( ).
*    customize layout
    init_layout( ).
*    set handlers to alv table
    attach_handlers( ).

    go_table->set_table_for_first_display(
      EXPORTING
        is_layout = gs_layout
      CHANGING
        it_outtab = ct_alv[]
        it_fieldcatalog = gt_fcat[] ).
  ENDMETHOD.                    "display

  "! <p class="shorttext synchronized" lang="en">Refresh ALV table display</p>
  "! Refreshes the ALV table display without scrolling to top, maintaining current position
  METHOD refresh.
*    refresh without scroll to top
    DATA ls_stable TYPE lvc_s_stbl.
    ls_stable-row = abap_true.
    ls_stable-col = abap_true.

    go_table->refresh_table_display( is_stable = ls_stable ).
  ENDMETHOD.                    "refresh

  "! <p class="shorttext synchronized" lang="en">Initialize field catalog for ALV</p>
  "! Automatically generates field catalog based on the structure of the ALV table
  "! @parameter it_alv | ALV table structure used for field catalog generation
  METHOD init_fcat.
    DATA:
      lo_row TYPE REF TO data,
      lo_rowdescr TYPE REF TO cl_abap_structdescr,
      lt_dfies TYPE ddfields.

    FIELD-SYMBOLS:
      <ls_dfies> TYPE LINE OF ddfields,
      <ls_fcat> LIKE LINE OF gt_fcat[].

    CREATE DATA lo_row LIKE LINE OF it_alv.
    lo_rowdescr ?= cl_abap_structdescr=>describe_by_data_ref( lo_row ).
    lt_dfies = cl_salv_data_descr=>read_structdescr( lo_rowdescr ).

    LOOP AT lt_dfies[] ASSIGNING <ls_dfies>.
      APPEND INITIAL LINE TO gt_fcat[] ASSIGNING <ls_fcat>.
      MOVE-CORRESPONDING <ls_dfies> TO <ls_fcat>.
    ENDLOOP.
  ENDMETHOD.                    "init_fcat

  "! <p class="shorttext synchronized" lang="en">Update field catalog with custom settings</p>
  "! Customizes field catalog entries with specific business logic settings
  METHOD update_fcat.
    FIELD-SYMBOLS: <ls_fcat>  TYPE LINE OF lvc_t_fcat.

    LOOP AT gt_fcat ASSIGNING <ls_fcat>.
      CASE <ls_fcat>-fieldname.
        WHEN 'CHECKBX'.
*      creation checkbox column
          <ls_fcat>-reptext   = 'Checkbox'.
          <ls_fcat>-edit      = abap_true.
          <ls_fcat>-checkbox  = abap_true.
          <ls_fcat>-outputlen = 8.
        WHEN 'LOW' or 'HIGH'.
          <ls_fcat>-outputlen = 50.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.                    "update_fcat

  "! <p class="shorttext synchronized" lang="en">Initialize ALV layout settings</p>
  "! Sets up basic layout properties for the ALV display
  METHOD init_layout.
    gs_layout-zebra = abap_true.
  ENDMETHOD.                    "init_layout

  "! <p class="shorttext synchronized" lang="en">Attach event handlers to ALV</p>
  "! Registers event handlers and enables edit events for the ALV grid
  METHOD attach_handlers.
    go_table->register_edit_event( cl_gui_alv_grid=>mc_evt_enter ).

    SET HANDLER go_controller->handle_double_click FOR go_table.
  ENDMETHOD.                    "attach_handlers

  "! <p class="shorttext synchronized" lang="en">Display error message</p>
  "! Shows an error message to the user
  "! @parameter iv_message | Error message text to display
  METHOD error_message.
    MESSAGE iv_message TYPE 'E'.
  ENDMETHOD.                    "error_message

  "! <p class="shorttext synchronized" lang="en">Display information message</p>
  "! Shows an information message to the user
  "! @parameter iv_message | Information message text to display
  METHOD info_message.
    MESSAGE iv_message TYPE 'I'.
  ENDMETHOD.                    "info_message

  "! <p class="shorttext synchronized" lang="en">Check for changed data in ALV</p>
  "! Validates and processes any changed data in the ALV grid
  METHOD check_changed_data.
    go_table->check_changed_data( ).
  ENDMETHOD.                    "check_changed_data

ENDCLASS.                    "lcl_mvc_view IMPLEMENTATION
