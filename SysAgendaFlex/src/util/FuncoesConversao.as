package util
{
	import com.adobe.fiber.runtime.lib.StringFunc;
	
	import flash.globalization.NumberFormatter;
	
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.formatters.CurrencyFormatter;
	import mx.formatters.DateFormatter;
	
	import org.granite.math.BigDecimal;
	import org.granite.math.MathContext;
	import org.granite.math.RoundingMode;
	
	public class FuncoesConversao
	{
		
		private static var formatDateTime :DateFormatter ;
		private static var formatTime :DateFormatter ;
		private static var formatDate :DateFormatter ;
		private static var formatMesAno :DateFormatter ;

		private static var formatMoney :CurrencyFormatter;
		private static var formatNumber :CurrencyFormatter;
		private static var formatPercent :CurrencyFormatter;
		private static var formatPercent2 :CurrencyFormatter;
		private static var formatPercent12 :NumberFormatter;
		private static const DIAS_SEMANA:Array = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
		
		//Static
		{
			//DateTime
			formatDateTime = new DateFormatter();
			formatDateTime.formatString = 'DD/MM/YYYY HH:NN';
			formatTime = new DateFormatter();
			formatTime.formatString = 'HH:NN';

			//Date
			formatDate = new DateFormatter();
			formatDate.formatString = "DD/MM/YYYY";
			
			//Date
			formatMesAno = new DateFormatter();
			formatMesAno.formatString = "MM/YYYY";
			
			//Money
			formatMoney = new CurrencyFormatter();
			formatMoney.precision = 2;
			formatMoney.currencySymbol = "R$ ";
			formatMoney.decimalSeparatorTo = ",";
			formatMoney.thousandsSeparatorTo = ".";
			formatMoney.useNegativeSign = true;
			formatMoney.useThousandsSeparator = true;
			formatMoney.alignSymbol = "left";
			
			//Number
			formatNumber = new CurrencyFormatter();
			formatNumber.precision = 2;
			formatNumber.currencySymbol = "";
			formatNumber.decimalSeparatorTo = ",";
			formatNumber.thousandsSeparatorTo = ".";
			formatNumber.useNegativeSign = true;
			formatNumber.useThousandsSeparator = true;
			formatNumber.alignSymbol = "left";
			
			//Percent
			formatPercent = new CurrencyFormatter();
			formatPercent.precision = 2;
			formatPercent.currencySymbol = "%";
			formatPercent.decimalSeparatorTo = ",";
			formatPercent.thousandsSeparatorTo = ".";
			formatPercent.useNegativeSign = true;
			formatPercent.useThousandsSeparator = true;
			formatPercent.alignSymbol = "right";			
			
			//Percent2
			formatPercent2 = new CurrencyFormatter();
			formatPercent2.precision = -1;
			formatPercent2.currencySymbol = "%";
			formatPercent2.decimalSeparatorTo = ",";
			formatPercent2.thousandsSeparatorTo = ".";
			formatPercent2.useNegativeSign = true;
			formatPercent2.useThousandsSeparator = true;
			formatPercent2.alignSymbol = "right";			
		}
		
		//Date
		public static function stringToDate(value :String):Date 
		{
			try {
				var array :Array = value.split("/");
				return new Date(array[2], array[1]-1, array[0]);
			} catch (e :Error) { } 
			return null;	
		}
		
		public static function dateTimeToString(value :Date):String 
		{
			return formatDateTime.format(value);
		}	
		
		public static function dateToTimeString(value :Date):String 
		{
			return formatTime.format(value);
		}
		
		public static function stringToDateTime(value :String):Date 
		{
			var dia:int = parseInt(value.substr(0, 2));
			var mes:int =  parseInt(value.substr(3, 2))-1;
			var ano:int =  parseInt(value.substr(6, 4));
			var hora:int =  parseInt(value.substr(11, 2));
			var minuto:int = parseInt(value.substr(14, 2));
			return new Date(ano, mes, dia, hora, minuto);
		}		
		
		public static function dateToString(value :Date):String 
		{
			return formatDate.format(value);
		}
		
		public static function dateMesAnoToString(value :Date):String 
		{
			return formatMesAno.format(value);
		}
		
		public static function dateToDiaSem(value :Date):String 
		{
			return DIAS_SEMANA[value.day];;
		}
		
		//Money
		public static function floatToStringMoney(value :Number) :String
		{
			try { 
				return formatMoney.format(value);
			} catch (e :Error) {			} 
			return "";
		}
		
		public static function stringToStringMoney(value :String) :String
		{
			return floatToStringMoney(parseFloat(value));
		}		
		
		//Number
		public static function floatToStringNumber(valor :Number) :String
		{
			try { 
				return formatNumber.format(valor);
			} catch (e :Error) {			} 
			return "";
		}
		
		public static function stringToStringNumber(value :String) :String
		{
			return floatToStringNumber(parseFloat(value));
		}		
		
		//Percent
		public static function floatToStringPercent(valor :Number) :String
		{
			try { 
				return formatPercent.format(valor);
			} catch (e :Error) {			} 
			return "";
		}
		//Percent2
		public static function floatToStringPercent2(valor :Number) :String
		{
			try { 
				return formatPercent2.format(valor);
			} catch (e :Error) {			} 
			return "";
		}
		
		public static function bdToStringPercent(valor :BigDecimal) :String
		{
			try { 
				return formatPercent.format(valor);
			} catch (e :Error) {			} 
			return "";
		}
		
		public static function stringToStringPercent(value :String) :String
		{
			return floatToStringPercent(parseFloat(value));
		}	
		
		public static function stringToStringPercent2(value :String) :String
		{
			return floatToStringPercent2(parseFloat(value));
		}	
		
		//Big Decimal
		public static function stringAllToBigDecimal(value :String) :BigDecimal
		{
			if(value != "")
				return new BigDecimal(stringAllToString(value));
			else return null
		}
		
		public static function bigDecimalToStringMoney(value :BigDecimal) :String
		{
			return stringToStringMoney(value.toString());
		}
		
		public static function bigDecimalToStringQtd(value :BigDecimal) :String
		{
			return stringToStringNumber(value.toString());
		}
		
		public static function bigDecimalToString(value :BigDecimal) :String
		{
			if(value != null)
				return value.toString();
			else
				return null;
		}
		
		//All
		public static function stringAllToFloat(value :String) :Number
		{
			return parseFloat(stringAllToString(value));
		}
		
		public static function stringAllToString(value :String) :String
		{
			if ( value == null ) {
				return "0";
			}
				
			value = StringFunc.replaceAll(value,"R$","");
			value = StringFunc.replaceAll(value,"%","");
			value = StringFunc.replaceAll(value," ","");
			
			if(value.search(",") != -1){ 			
				value = StringFunc.replaceAll(value, ".", "");
				value = StringFunc.replaceAll(value, ",",".");
			}
			
			if (!isNaN(Number(value))) {	
				return value;
			}
			
			return "0";
		}	
		
		public static function numberToString(value :Number):String
		{
			return value.toFixed(2);
		}
		
		public static function trocaPontoPercent(text:String):Object
		{
			return text.replace(",",".");
		}
	}
}