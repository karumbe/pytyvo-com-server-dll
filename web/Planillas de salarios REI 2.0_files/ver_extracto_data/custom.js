/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * 
 * @param {type} imput 
 * @returns {Number|bandera}
 */
 function validar_imput_vacios(imput){
	bandera=0;
	if(document.getElementById(imput).value==""){
		bandera=1;
		document.getElementById(imput).className="imput_rojo";
	}
        else
        {
            document.getElementById(imput).className="form-control";
        }
	//alert(bandera);
        return bandera;
}
/*
 * 
 * @type type
 */

  /**

	 * FUNCION PARA CALCULO DE DIFERENCIA DE HORAS CON JAVASCRIPT

	 */

	function isValidDate(day,month,year)

	{

		var dteDate;

		month=month-1;

		dteDate=new Date(year,month,day);

		return ((day==dteDate.getDate()) && (month==dteDate.getMonth()) && (year==dteDate.getFullYear()));

	}

 

	/**

	 * Funcion para validar una fecha

	 * Tiene que recibir:

	 *  La fecha en formato español dd/mm/yyyy

	 * Devuelve:

	 *  true o false

	 */

	function validate_fecha(fecha)

	{

		var patron=new RegExp("^([0-9]{1,2})([-])([0-9]{1,2})([-])(19|20)+([0-9]{2})$");

 

		if(fecha.search(patron)==0)

		{

			var values=fecha.split("-");

			if(isValidDate(values[0],values[1],values[2]))

			{

				return true;

			}

		}

		return false;

	}

 

    function calcularDias()

    {

		var fechaInicial=document.getElementById("fechaInicio").value;

		var fechaFinal=document.getElementById("fechaFin").value;

		var resultado="";

		if(validate_fecha(fechaInicial) && validate_fecha(fechaFinal))

		{

			inicial=fechaInicial.split("-");

			final=fechaFinal.split("-");

			// obtenemos las fechas en milisegundos

			var dateStart=new Date(inicial[2],(inicial[1]-1),inicial[0]);

            var dateEnd=new Date(final[2],(final[1]-1),final[0]);

            if(dateStart<=dateEnd)

            {

				// la diferencia entre las dos fechas, la dividimos entre 86400 segundos

				// que tiene un dia, y posteriormente entre 1000 ya que estamos

				// trabajando con milisegundos.

				//resultado="La diferencia es de "+(((dateEnd-dateStart)/86400)/1000)+" días";
				var aux = (((dateEnd-dateStart)/86400)/1000);
                                document.getElementById('duracion').value= aux+1;

			}else{

				alert("La fecha inicial es posterior a la fecha final");

			}

		}else{

			if(!validate_fecha(fechaInicial))

				alert("La fecha inicial es incorrecta");

			if(!validate_fecha(fechaFinal))

				alert("La fecha final es incorrecta");

		}
		//document.getElementById("resultado").innerHTML=resultado;
    }
	
