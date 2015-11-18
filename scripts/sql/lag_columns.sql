select count1.*, count2.total_events from
  count_events_grouped_by_day count1
  join count_events_grouped_by_day count2 on (count1.SQLDATE-1 = count2.SQLDATE);

