function active(){
	$val = $("#option_sell").val();
	if($val == "Rent"){
		$("#1renta").css("display", "inherit");
		$("#2renta").css("display", "inherit");
		$("#3renta").css("display", "inherit");
		$("#venta").css("display", "none");
	}else{
		$("#1renta").css("display", "none");
		$("#2renta").css("display", "none");
		$("#3renta").css("display", "none");
		$("#venta").css("display", "inherit");
	}

}

function show_load(){
	$("#backspinner").removeClass("dispnone");
}
function modificar(){
	$("#price_rent").val($("#priceweek").val() * $("#numweek").val())
}
function open_modal(){
	$(".data_contract").toggle("dispnone");
}
function viewforms(form){
	if(form == "mail"){
		$("#"+form).removeClass("dispnone");
		$("#history").addClass("dispnone");
	}else{
		$("#"+form).removeClass("dispnone");
		$("#mail").addClass("dispnone");
	}
}
function search() {
    var input, filter, table, tr, td, i;
    input = document.getElementById("filter");
    filter = input.value.toUpperCase();
    table = document.getElementById("elements");
    tr = table.getElementsByTagName("tr");
    for (i = 0; i < tr.length; i++) {
      td = tr[i].getElementsByTagName("td")[1];
      if (td) {
        if (td.innerHTML.toUpperCase().indexOf(filter) >= 0 || filter =="") {    	
          tr[i].style.display = "";
        } else {
          tr[i].style.display = "none";
        }
      }
    }
  }