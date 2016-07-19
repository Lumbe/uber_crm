/* ------------------------------------------------------------------------------
*
*  # Input groups
*
*  Specific JS code additions for form_input_groups.html page
*
*  Version: 1.0
*  Latest update: Aug 1, 2015
*
* ---------------------------------------------------------------------------- */

$(function() {

    // Update uniform when select between styled and unstyled
    $('.input-group-addon input[type=radio]').on('click', function() {
        $.uniform.update("[name=addon-radio]");
    });

});
