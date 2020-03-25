/**
 * This array is used to remember mark status of rows in browse mode
 */
var marked_row = new Array;


/**
 * Sets/unsets the pointer and marker in browse mode
 *
 * @param   object    the table row
 * @param   integer  the row number
 * @param   string    the action calling this script (over, out or click)
 * @param   string    the default background color
 * @param   string    the color to use for mouseover
 * @param   string    the color to use for marking a row
 *
 * @return  boolean  whether pointer is set or not
 */
function setPointer(theRow, theRowNum, theAction, theDefaultColor, thePointerColor, theMarkColor)
{
    var theCells = null;

    // 1. Pointer and mark feature are disabled or the browser can't get the
    //    row -> exits
    if ((thePointerColor == '' && theMarkColor == '')
        || typeof(theRow.style) == 'undefined') {
        return false;
    }

    // 2. Gets the current row and exits if the browser can't get it
    if (typeof(document.getElementsByTagName) != 'undefined') {
        theCells = theRow.getElementsByTagName('td');
    }
    else if (typeof(theRow.cells) != 'undefined') {
        theCells = theRow.cells;
    }
    else {
        return false;
    }

    // 3. Gets the current color...
    var rowCellsCnt  = theCells.length;
    var domDetect    = null;
    var currentColor = null;
    var newColor     = null;
    // 3.1 ... with DOM compatible browsers except Opera that does not return
    //         valid values with "getAttribute"
    if (typeof(window.opera) == 'undefined'
        && typeof(theCells[0].getAttribute) != 'undefined') {
        currentColor = theCells[0].getAttribute('bgcolor');
        domDetect    = true;
    }
    // 3.2 ... with other browsersmer
    else {
        currentColor = theCells[0].style.backgroundColor;
        domDetect    = false;
    } // end 3

    // 3.3 ... Opera changes colors set via HTML to rgb(r,g,b) format so fix it
    if (currentColor.indexOf("rgb") >= 0)
    {
        var rgbStr = currentColor.slice(currentColor.indexOf('(') + 1,
                                     currentColor.indexOf(')'));
        var rgbValues = rgbStr.split(",");
        currentColor = "#";
        var hexChars = "0123456789ABCDEF";
        for (var i = 0; i < 3; i++)
        {
            var v = rgbValues[i].valueOf();
            currentColor += hexChars.charAt(v/16) + hexChars.charAt(v%16);
        }
    }

    // 4. Defines the new color
    // 4.1 Current color is the default one
    if (currentColor == ''
        || currentColor.toLowerCase() == theDefaultColor.toLowerCase()) {
        if (theAction == 'over' && thePointerColor != '') {
            newColor              = thePointerColor;
        }
        else if (theAction == 'click' && theMarkColor != '') {
            newColor              = theMarkColor;
            marked_row[theRowNum] = true;
            // Garvin: deactivated onclick marking of the checkbox because it's also executed
            // when an action (like edit/delete) on a single item is performed. Then the checkbox
            // would get deactived, even though we need it activated. Maybe there is a way
            // to detect if the row was clicked, and not an item therein...
            // document.getElementById('id_rows_to_delete' + theRowNum).checked = true;
        }
    }
    // 4.1.2 Current color is the pointer one
    else if (currentColor.toLowerCase() == thePointerColor.toLowerCase()
             && (typeof(marked_row[theRowNum]) == 'undefined' || !marked_row[theRowNum])) {
        if (theAction == 'out') {
            newColor              = theDefaultColor;
        }
        else if (theAction == 'click' && theMarkColor != '') {
            newColor              = theMarkColor;
            marked_row[theRowNum] = true;
            // document.getElementById('id_rows_to_delete' + theRowNum).checked = true;
        }
    }
    // 4.1.3 Current color is the marker one
    else if (currentColor.toLowerCase() == theMarkColor.toLowerCase()) {
        if (theAction == 'click') {
            newColor              = (thePointerColor != '')
                                  ? thePointerColor
                                  : theDefaultColor;
            marked_row[theRowNum] = (typeof(marked_row[theRowNum]) == 'undefined' || !marked_row[theRowNum])
                                  ? true
                                  : null;
            // document.getElementById('id_rows_to_delete' + theRowNum).checked = false;
        }
    } // end 4

    // 5. Sets the new color...
    if (newColor) {
        var c = null;
        // 5.1 ... with DOM compatible browsers except Opera
        if (domDetect) {
            for (c = 0; c < rowCellsCnt; c++) {
                theCells[c].setAttribute('bgcolor', newColor, 0);
            } // end for
        }
        // 5.2 ... with other browsers
        else {
            for (c = 0; c < rowCellsCnt; c++) {
                theCells[c].style.backgroundColor = newColor;
            }
        }
    } // end 5

    return true;
} // end of the 'setPointer()' function

function calcular_duracion(dia_ini, mes_ini, ano_ini, dia_fin, mes_fin, ano_fin)
{

	var fecha_permiso_ini= new Date((ano_ini),(mes_ini),(dia_ini));
	var fecha_permiso_fin= new Date((ano_fin),(mes_fin),(dia_fin));
	
	
	dif = (fecha_permiso_fin) - (fecha_permiso_ini);
	dif = (dif/86400000) + 1;
	return dif;
}

function buscar_text(texto)
{
	var resu;				
	var patron = / /g;
	resu = texto.value.replace(patron,"");
	texto.value = resu;
}				
			
function trim(texto)
{
	var i;
	var resu = texto.value;				
	var patron = / /;
	var cant = texto.value.length;
	var text_ent_cp =  new String();
	text_ent_cp = texto.value;
	for (i=0;i<cant;i++)
	{
		if (text_ent_cp.charAt(i) == " ")
		{
			resu = resu.replace(patron,"");
		}
		else
		{
			break;
		}

	}
	texto.value = resu;
}
			function validar_email(email)
			{
					EmailString = email.value;
					//Look for "@" to find the main host
					atOne = EmailString.indexOf("@")

					if (atOne > 0) 
					{
						emailUser = EmailString.substring(0,atOne);
						emailHost = EmailString.substring((atOne + 1));
					} 
					else 
					{
						alert("El valor del Correo Eléctronico no es válido");
						email.focus();
						return false;
					}
					//Search for "." in host
					dotOne = emailHost.indexOf(".")

					if (dotOne == -1) 
					{
						alert("El valor del Correo Eléctronico no es válido");
						email.focus();
						return false;
					}
					return true;
			}

function contar_caracteres(cadena, borrar)
{
	MAXCHAR = 200;			
	total = (cadena.value.length);
	cadena.value = cadena.value.substring(0,200);
	if (total > MAXCHAR)
	{
		
		alert("El numero máximo de carateres soportado es " + MAXCHAR + ".\n Ud. ingreso " + total + ".");
		borrar.value = "("+(MAXCHAR-total)+") Limpiar Campo";
	}
	borrar.value = "("+(MAXCHAR-total)+") Limpiar Campo";
}

function falta_ide_asecot()
{
	document.write("falta ingresar el Nro. de cédula del asegurado ");
	
}
 function format(input){
  var num = input.value.replace(/\,/g,'');
   if(!isNaN(num)){
     if(num.indexOf('.') > -1){ 
        num = num.split('.');
        num[0] = num[0].toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g,'$1,').split('').reverse().join('').replace(/^[\,]/,'');
       if(num[1].length > 2){ 
          alert('You may only enter two decimals!');
          num[1] = num[1].substring(0,num[1].length-1);
       }  input.value = num[0]+'.'+num[1];        
     } else{ input.value = num.toString().split('').reverse().join('').replace(/(?=\d*\.?)(\d{3})/g,'$1,').split('').reverse().join('').replace(/^[\,]/,'') };
   }
   else{ alert('You may enter only numbers in this field!');
         input.value = input.value.substring(0,input.value.length-1);
   }
 }

			var digitos=10 //cantidad de digitos buscados 
			var puntero=0 
			var buffer=new Array(digitos) //declaración del array Buffer 
			var cadena="" 

			function buscar_op(obj){ 
			   var letra = String.fromCharCode(event.keyCode) 
			   if(puntero >= digitos){ 
				   //cadena=""; 
				  puntero=0; 
				} 
			   //si se presiona la tecla ENTER, borro el array de teclas presionadas y salto a otro objeto... 
			   if (event.keyCode == 13){ 
				   borrar_buffer(); 
				  // if(objfoco!=0) objfoco.focus(); //evita foco a otro objeto si objfoco=0 
				} 
			   //sino busco la cadena tipeada dentro del combo... 
			   else{ 
				   buffer[puntero]=letra; 
				   //guardo en la posicion puntero la letra tipeada 
				   cadena=cadena+buffer[puntero]; //armo una cadena con los datos que van ingresando al array 
				   puntero++; 

				   //barro todas las opciones que contiene el combo y las comparo la cadena... 
				   for (var opcombo=0;opcombo < obj.length;opcombo++){ 
					  if(obj[opcombo].text.substr(0,puntero).toLowerCase()==cadena.toLowerCase()){ 
					  obj.selectedIndex=opcombo; 
					  } 
				   } 
				} 
			   event.returnValue = false; //invalida la acción de pulsado de tecla para evitar busqueda del primer caracter 
			} 
			function borrar_buffer(){ 
			   //inicializa la cadena buscada 
				cadena=""; 
				puntero=0; 
			} 

			function Upper(TextField)
			{
				TextField.value = TextField.value.toUpperCase();
			}

			function enviar_punto(campo, tipo_campo)
			{
				if (campo.value == "")
				{
					if (tipo_campo == "N")
					{
						campo.value = 0;
						return;
					}
					if (tipo_campo == "S")
					{
						campo.value = '.';
						return;
					}

				}

			}

			function enter(form,field)
			{
			var next=0, found=false
			var f=form
			if(event.keyCode!=13) return;
				for(var i=0;i<f.length;i++) 
				{
					if(field.name==f.item(i).name)
					{
					next=i+1;
					found=true
					break;
					}
				}
				while(found)
				{
					if( f.item(next).disabled==false && f.item(next).type!='hidden')
					{
					f.item(next).focus();
					break;
					}
					else
					{
						if(next<f.length-1)
							next=next+1;
						else
							break;
					}
				}
			}

	function pop(file, ancho, alto, tool, resize, scroll, menubar, status)
	{
		var w = screen.availWidth, h = screen.availHeight;
		var leftPos = (w-ancho)/2, topPos = (h-alto)/2;
			pop_window = window.open(file ,'files','width='+ancho+',height='+alto+',menubar='+menubar
			+',toolbar='+tool+',status='+status+',scrollbars='+scroll+',resizable='+resize+',top=' + topPos + ',left=' + leftPos);
	}
	  function pop2(file, ancho, alto, tool, resize, scroll, menubar, status)
	  {
		var order = document.getElementById('order').value;
		var w = screen.availWidth, h = screen.availHeight;
		var leftPos = (w-ancho)/2, topPos = (h-alto)/2;
			pop_window = window.open(file+"&order="+order ,'files','width='+ancho+',height='+alto+',menubar='+menubar
			+',toolbar='+tool+',status='+status+',scrollbars='+scroll+',resizable='+resize+',top=' + topPos + ',left=' + leftPos);
	  }

	function imprimir_tar()
	{
		var ide_emplea;
		var cod_period;
		ide_emplea = document.forms[0].ide_emplea.value;
		cod_period = document.forms[0].periodo.value;
		order = document.forms[2].order.value;

		window.open('abre_tarjetita_pdf.php?pag_pdf=inf_tarjetita_pdf.php&ide_emplea='+ide_emplea+'&cod_period='+$cod_period+'&ide_asecot=-1&order='+order,1100, 750, 0, 1, 1, 0, 1);

	}

	function setPointer(theRow, theRowNum, theAction, theDefaultColor, thePointerColor, theMarkColor)
{
    var theCells = null;

    // 1. Pointer and mark feature are disabled or the browser can't get the
    //    row -> exits
    if ((thePointerColor == '' && theMarkColor == '')
        || typeof(theRow.style) == 'undefined') {
        return false;
    }

    // 2. Gets the current row and exits if the browser can't get it
    if (typeof(document.getElementsByTagName) != 'undefined') {
        theCells = theRow.getElementsByTagName('td');
    }
    else if (typeof(theRow.cells) != 'undefined') {
        theCells = theRow.cells;
    }
    else {
        return false;
    }

    // 3. Gets the current color...
    var rowCellsCnt  = theCells.length;
    var domDetect    = null;
    var currentColor = null;
    var newColor     = null;
    // 3.1 ... with DOM compatible browsers except Opera that does not return
    //         valid values with "getAttribute"
    if (typeof(window.opera) == 'undefined'
        && typeof(theCells[0].getAttribute) != 'undefined') {
        currentColor = theCells[0].getAttribute('bgcolor');
        domDetect    = true;
    }
    // 3.2 ... with other browsersmer
    else {
        currentColor = theCells[0].style.backgroundColor;
        domDetect    = false;
    } // end 3

    // 3.3 ... Opera changes colors set via HTML to rgb(r,g,b) format so fix it
    if (currentColor.indexOf("rgb") >= 0)
    {
        var rgbStr = currentColor.slice(currentColor.indexOf('(') + 1,
                                     currentColor.indexOf(')'));
        var rgbValues = rgbStr.split(",");
        currentColor = "#";
        var hexChars = "0123456789ABCDEF";
        for (var i = 0; i < 3; i++)
        {
            var v = rgbValues[i].valueOf();
            currentColor += hexChars.charAt(v/16) + hexChars.charAt(v%16);
        }
    }

    // 4. Defines the new color
    // 4.1 Current color is the default one
    if (currentColor == ''
        || currentColor.toLowerCase() == theDefaultColor.toLowerCase()) {
        if (theAction == 'over' && thePointerColor != '') {
            newColor              = thePointerColor;
        }
        else if (theAction == 'click' && theMarkColor != '') {
            newColor              = theMarkColor;
            marked_row[theRowNum] = true;
            // Garvin: deactivated onclick marking of the checkbox because it's also executed
            // when an action (like edit/delete) on a single item is performed. Then the checkbox
            // would get deactived, even though we need it activated. Maybe there is a way
            // to detect if the row was clicked, and not an item therein...
            // document.getElementById('id_rows_to_delete' + theRowNum).checked = true;
        }
    }
    // 4.1.2 Current color is the pointer one
    else if (currentColor.toLowerCase() == thePointerColor.toLowerCase()
             && (typeof(marked_row[theRowNum]) == 'undefined' || !marked_row[theRowNum])) {
        if (theAction == 'out') {
            newColor              = theDefaultColor;
        }
        else if (theAction == 'click' && theMarkColor != '') {
            newColor              = theMarkColor;
            marked_row[theRowNum] = true;
            // document.getElementById('id_rows_to_delete' + theRowNum).checked = true;
        }
    }
    // 4.1.3 Current color is the marker one
    else if (currentColor.toLowerCase() == theMarkColor.toLowerCase()) {
        if (theAction == 'click') {
            newColor              = (thePointerColor != '')
                                  ? thePointerColor
                                  : theDefaultColor;
            marked_row[theRowNum] = (typeof(marked_row[theRowNum]) == 'undefined' || !marked_row[theRowNum])
                                  ? true
                                  : null;
            // document.getElementById('id_rows_to_delete' + theRowNum).checked = false;
        }
    } // end 4

    // 5. Sets the new color...
    if (newColor) {
        var c = null;
        // 5.1 ... with DOM compatible browsers except Opera
        if (domDetect) {
            for (c = 0; c < rowCellsCnt; c++) {
                theCells[c].setAttribute('bgcolor', newColor, 0);
            } // end for
        }
        // 5.2 ... with other browsers
        else {
            for (c = 0; c < rowCellsCnt; c++) {
                theCells[c].style.backgroundColor = newColor;
            }
        }
    } // end 5

    return true;
} // end of the 'setPointer()' function