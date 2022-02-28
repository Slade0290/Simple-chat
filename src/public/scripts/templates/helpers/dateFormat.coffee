import moment from 'moment'

export default (date)->
  console.log 'date', date
  moment(date).format("MM/DD/YYYY")
