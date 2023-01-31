package util {
	
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.StaticText;
	
	import mx.collections.ArrayCollection;
	import mx.controls.LinkButton;
	import mx.controls.ProgressBar;
	import mx.events.ModuleEvent;
	import mx.modules.ModuleLoader;
	import mx.modules.ModuleManager;
	import mx.states.AddChild;
	import mx.states.RemoveChild;
	
	import spark.components.Application;
	import spark.components.BorderContainer;
	import spark.components.Button;
	import spark.components.Group;
	import spark.components.NavigatorContent;
	import spark.components.SkinnableContainer;
	
	
	public class ControlNavegacao {
		
		private static var bar :ProgressBar;
		private static var btAnterior :LinkButton;
		private static var btProximo :LinkButton;
		private static var areaVisualizacao :Group;
		private static var area :ModuleLoader;
		private static var areasAnteriores :ArrayCollection;
		private static var areasProximas :ArrayCollection;
		private static var areaAtual :String;
		private static var btSair :LinkButton;
		private static var isCol :Boolean = false; //Colaborador
		private static var isFor :Boolean = false; //Fornecedor
		
		public static function setBtSair(c :LinkButton) :void 
		{
			btSair = c;
		}
		
		public static function setArea(areaCarregavel:Group):void 
		{
			areaVisualizacao = areaCarregavel;
			areasAnteriores = new ArrayCollection();
			areasProximas = new ArrayCollection();
			areaAtual = "";
		}
		
		public static function setProgress(progressBar:ProgressBar):void 
		{
			bar = progressBar;
		}
		
		public static function setBtProximo(bt :LinkButton) :void 
		{
			btProximo = bt;
		}
		
		public static function setBtAnterior(bt :LinkButton) :void 
		{
			btAnterior = bt;
		}
		
		public static function loadTela(tela :String) :void 
		{	
			areasAnteriores.addItem(areaAtual);

			unLoad(areaAtual);
			load(tela);
			areaAtual = tela;
			
			if ( btAnterior != null )
				btAnterior.enabled = areasAnteriores.length > 1;
			
			if ( btProximo != null )
				btProximo.enabled = false;
			
			if ( areasProximas.length > 0 ) 
			{
				areasProximas = new ArrayCollection;
			} 			
		}

		private static function unLoad(tela :String) :void 
		{
			if ( area != null )
			{
				areaVisualizacao.removeAllElements();
				area.unloadModule();
				System.gc();
			}
		}
		
		private static function load(tela :String) :void 
		{		
			area = new ModuleLoader();
			area.minWidth = 990;
			area.minHeight = 550;
			area.percentWidth = 100;
			area.percentHeight = 100;
			area.url = tela;
			area.loadModule();
						
			bar.source = area; 
			bar.visible = true;
			area.addEventListener(ModuleEvent.READY, loadTerminado);
		}

		public static function loadScreenPrior() :void 
		{
			areasProximas.addItem(areaAtual);
			
			var count :int = areasAnteriores.length - 1;
			var tela :String =  areasAnteriores.getItemAt(count) as String;
			areasAnteriores.removeItemAt(count);
			
			unLoad(areaAtual);
			load(tela);
			areaAtual = tela;
			
			btAnterior.enabled = count > 1;
			
			btProximo.enabled = true;
		}

		public static function loadScreenNext() :void 
		{
			areasAnteriores.addItem(areaAtual);
			
			var count :int = areasProximas.length - 1;
			var tela :String =  areasProximas.getItemAt(count) as String;
			areasProximas.removeItemAt(count);
			
			unLoad(areaAtual);
			loadTela(tela);
			areaAtual = tela;
			
			btAnterior.enabled = true;
			
			btProximo.enabled = areasProximas.length > 0;
		}

		private static function loadTerminado(event:ModuleEvent) :void 
		{ 	
			bar.visible=false;
			areaVisualizacao.addElement(area);
			area.removeEventListener(ModuleEvent.READY, loadTerminado); 
			area.child.addEventListener("trocaTela", trocaTela);
			area.child.addEventListener("logoff", logoff);
		}
		
		private static function trocaTela(event:EventTrocaTela) :void 
		{
			loadTela(event.getModulo());
		}
		
		public static function logoff():void
		{
			btSair.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}	
		
		public static function setIsFor(flag: Boolean):void
		{
			isFor = flag;
		}	
		
		public static function setIsCol(flag: Boolean):void
		{
			isCol = flag;
		}	
	}	
}