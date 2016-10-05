$ ->
  leadsChart = echarts.init(document.getElementById('leads_chart'), window.echarts.themes.limitless)
  leadsChart.setOption
    title:
      text: 'Источник'
      subtext: 'Откуда о нас узнали'
      x:'center'
    tooltip:
      trigger: 'item'
      formatter: '{a} <br/>{b} : {c} ({d}%)'
    legend:
      orient: 'vertical'
      x: 'left'
      data: [
        'Интернет'
        'Наружная реклама'
        'Печатные издания'
        'Маршрутки'
        'Личная рекомендация'
        'Буклеты, флаера'
        'Другое'
      ]
    toolbox:
      show: true
      feature:
        restore: show: true
        saveAsImage: show: true
    calculable: true
    series: [ {
      name: '访问来源'
      type: 'pie'
      radius: [
        '50%'
        '70%'
      ]
      itemStyle:
        normal:
          label: show: false
          labelLine: show: false
        emphasis: label:
          show: true
          position: 'center'
          textStyle:
            fontSize: '30'
            fontWeight: 'bold'
      data: [
        {
          value: 1548
          name: 'Интернет'
        }
        {
          value: 310
          name: 'Наружная реклама'
        }
        {
          value: 234
          name: 'Печатные издания'
        }
        {
          value: 135
          name: 'Маршрутки'
        }
        {
          value: 112
          name: 'Личная рекомендация'
        }
        {
          value: 117
          name: 'Буклеты, флаера'
        }
        {
          value: 225
          name: 'Другое'
        }
      ]
    } ]
    
  contactsChart = echarts.init(document.getElementById('contacts_chart'), window.echarts.themes.limitless)
  contactsChart.setOption
    title:
      x: 'center'
      text: 'Лиды'
    tooltip: trigger: 'item'
    toolbox:
      show: true
      feature:
        restore: show: true
        saveAsImage: show: true
    calculable: true
    grid:
      borderWidth: 0
      y: 80
      y2: 60
    xAxis: [ {
      type: 'category'
      show: false
      data: [
        'Добавлено'
        'Конвертировано'
        'Повторно'
        'Делегировано'
        'Передано'
      ]
    } ]
    yAxis: [ {
      type: 'value'
      show: false
    } ]
    series: [ {
      name: 'Лиды'
      type: 'bar'
      itemStyle: normal:
        color: (params) ->
          # build a color map as your need.
          colorList = [
            '#C1232B'
            '#B5C334'
            '#FCCE10'
            '#E87C25'
            '#27727B'
            '#FE8463'
            '#9BCA63'
            '#FAD860'
            '#F3A43B'
            '#60C0DD'
            '#D7504B'
            '#C6E579'
            '#F4E001'
            '#F0805A'
            '#26C0C0'
          ]
          colorList[params.dataIndex]
        label:
          show: true
          position: 'top'
          formatter: '{b}\n{c}'
      data: [
        21
        18
        10
        4
        6
      ]
      markPoint:
        tooltip:
          trigger: 'item'
          backgroundColor: 'rgba(0,0,0,0)'
          formatter: (params) ->
            '<img src="' + params.data.symbol.replace('image://', '') + '"/>'
        data: [
          {
            xAxis: 0
            y: 350
            name: 'Line'
            symbolSize: 20
            symbol: 'image://../asset/ico/折线图.png'
          }
          {
            xAxis: 1
            y: 350
            name: 'Bar'
            symbolSize: 20
            symbol: 'image://../asset/ico/柱状图.png'
          }
          {
            xAxis: 2
            y: 350
            name: 'Scatter'
            symbolSize: 20
            symbol: 'image://../asset/ico/散点图.png'
          }
          {
            xAxis: 3
            y: 350
            name: 'K'
            symbolSize: 20
            symbol: 'image://../asset/ico/K线图.png'
          }
          {
            xAxis: 4
            y: 350
            name: 'Pie'
            symbolSize: 20
            symbol: 'image://../asset/ico/饼状图.png'
          }
          {
            xAxis: 5
            y: 350
            name: 'Radar'
            symbolSize: 20
            symbol: 'image://../asset/ico/雷达图.png'
          }
          {
            xAxis: 6
            y: 350
            name: 'Chord'
            symbolSize: 20
            symbol: 'image://../asset/ico/和弦图.png'
          }
          {
            xAxis: 7
            y: 350
            name: 'Force'
            symbolSize: 20
            symbol: 'image://../asset/ico/力导向图.png'
          }
          {
            xAxis: 8
            y: 350
            name: 'Map'
            symbolSize: 20
            symbol: 'image://../asset/ico/地图.png'
          }
          {
            xAxis: 9
            y: 350
            name: 'Gauge'
            symbolSize: 20
            symbol: 'image://../asset/ico/仪表盘.png'
          }
          {
            xAxis: 10
            y: 350
            name: 'Funnel'
            symbolSize: 20
            symbol: 'image://../asset/ico/漏斗图.png'
          }
        ]
    } ]
