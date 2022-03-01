import moment from 'moment'

export default (date)->
  moment(date).format("MM/DD/YYYY")
