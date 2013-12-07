package g1.common.utils
{
	import flash.external.ExternalInterface;
	/********************************************************
	 *			 Copyright (c) 2012 IGG研发中心
	 *               All rights reserved	
	 *
	 *		@创 建 时 间: 2012年5月31日9:45:22
	 *		@说       明: 刷新页面
	 *
	 *		@作       者: qishenglai
	 *		@版       本: 1.0.0
	 *      @概       述: 创建
	 *
	 *******************************************************/
	public class RefreshPage
	{
		public function RefreshPage()
		{
		}
		
		public static function fulshHtml():void
		{
			//刷新页面
			ExternalInterface.call("eval", "location.reload();");
		}

	}
}