import ApplicationController from './application_controller'
import ApexCharts from "apexcharts"

export default class extends ApplicationController {
  static targets = ["chart"]

  static values = {
    labels: Array,
    series: Array
  }

  initialize() {
    this.chart = new ApexCharts(this.chartTarget, this.chartOptions);
    this.chart.render();
  }

  update(event) {
    this.stimulate("HiringStages#update", event.target, { serializeForm: true })
  }

  afterUpdate() {
    this.chart.updateOptions(this.chartOptions);
  }

  get chartOptions() {
    return {
      chart: {
        type: 'pie',
        height: '400px'
      },
      series: this.seriesValue,
      labels: this.labelsValue,
    }
  }
}
