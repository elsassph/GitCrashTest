package testMap
{
	import com.google.maps.LatLng;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapOptions;
	import com.google.maps.services.ClientGeocoder;
	import com.google.maps.services.GeocodingEvent;
	import com.google.maps.services.Placemark;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	/**
	 * ...
	 * @author Philippe
	 */
	public class Main extends Sprite 
	{
		static private const API_KEY:String = "ABQIAAAA4RYfwOTqGOwh9KUivgHw-BQm6H6-lFEGyYYJ91h0yC3aeKLcJxQpna0NKkEc1Ry47f0XJutDhF0WRw";
		private var map:Map;
		private var place:Placemark;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			createMap();
		}
		
		private function createMap(loc:LatLng = null):void
		{
			map = new Map();
			map.key = API_KEY;
			if (loc) map.setCenter(loc, 13);
			map.addEventListener(MapEvent.MAP_READY, map_ready);
			addChild(map);
			map.visible = false;
			layout();
			stage.addEventListener(Event.RESIZE, layout);
		}
		
		private function map_ready(e:MapEvent):void 
		{
			map.enableScrollWheelZoom();
			getLocation("Marcel Samba, France");
		}
		
		private function getLocation(address:String):void
		{
			var geocoder:ClientGeocoder = new ClientGeocoder();
			geocoder.geocode(address);
			geocoder.addEventListener(GeocodingEvent.GEOCODING_FAILURE, geocode_fail);
			geocoder.addEventListener(GeocodingEvent.GEOCODING_SUCCESS, geocode_success);
		}
		
		private function geocode_fail(e:GeocodingEvent):void 
		{
			trace("geocode error");
		}
		
		private function geocode_success(e:GeocodingEvent):void 
		{
			place = e.response.placemarks[0];
			map.setCenter(place.point, 15);
			map.visible = true;
		}
		
		private function layout(e:Event = null):void 
		{
			map.setSize(new Point(stage.stageWidth, stage.stageHeight));
		}
		
	}
	
}