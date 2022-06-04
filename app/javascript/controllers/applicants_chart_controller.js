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

  get chartOptions() {
    return {
      chart: {
        height: "400px",
        type: 'line',
      },
      series: [{
        name: 'Applicants',
        data: this.seriesValue
      }],
      xaxis: {
        categories: this.labelsValue,
        type: 'datetime'
      },
      stroke: {
        curve: "smooth"
      }
    }
  }

  update() {
    this.stimulate('ApplicantsChart#update', event.target, { serializeForm: true })
  }

  afterUpdate() {
    this.chart.updateOptions({
      series: [{
        data: this.seriesValue
      }],
      xaxis: {
        categories: this.labelsValue
      }
    });
  }
}
