import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewChart extends StatefulWidget {
  final String symbol;
  final bool isLightMode;
  final String interval;

  const TradingViewChart({
    super.key,
    required this.symbol,
    this.isLightMode = true,
    this.interval = "1",
  });

  @override
  State<TradingViewChart> createState() => _TradingViewChartState();
}

class _TradingViewChartState extends State<TradingViewChart> {
  late final WebViewController _controller;

  String get htmlContent => '''
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
      html, body { 
      margin:0; 
      padding:0; 
      height:100%; 
      width:100%; 
      overflow:hidden;
      }
      #tradingview_chart { position:absolute; top:0; left:0; right:0; bottom:0;}
    </style>
  </head>
  <body>
    <div id="tradingview_chart"></div>
    <script src="https://s3.tradingview.com/tv.js"></script>
    <script>
      function loadChart() {
        if(typeof TradingView === 'undefined') { setTimeout(loadChart, 500); return; }

        tvWidget = new TradingView.widget({
          autosize: true,
          symbol: "${widget.symbol.toUpperCase()}USDT",
          interval: "${widget.interval}",
          timezone: "Etc/UTC",
          theme: "${widget.isLightMode ? 'light' : 'dark'}",
          style: "1",
          locale: "en",
          locale: "fr", 
          locale: "de",
          enable_publishing: false,
          hide_legend: false,
          hide_side_toolbar: true,
          hide_top_toolbar: true,
          toolbar_bg: "${widget.isLightMode ? '#00000' : '#1E1E1E'}",
          container_id: "tradingview_chart"
          
          
        });
        
      }
      loadChart();
    </script>
  </body>
</html>
''';

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadHtmlString(htmlContent, baseUrl: 'https://s3.tradingview.com/');
  }

  @override
  void didUpdateWidget(covariant TradingViewChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.interval != widget.interval) {
      // reload chart when interval changes
      _controller.loadHtmlString(htmlContent, baseUrl: 'https://s3.tradingview.com/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
