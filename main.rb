require 'csv'
data = CSV.read('dataset-1.csv', headers: true)

sales = {}
cumul = 0
totals = {}

data.each do |row|
  date = row['date']

  month, day, year = date.split('-')
  month = month.to_i
  day = day.to_i
  year = year.to_i
  time = Time.new(year, month, day)

  day_of_week = time.wday
  days_of_week = %w[sun mon tue wed thu fri sat]
  day_name = days_of_week[day_of_week]

  sku = row['sku']
  sale = row['units-sold']

  sales[sku] = [0, 0, 0, 0, 0, 0, 0, 0] if sales[sku].nil?

  totals[sku] ||= 0

  # Ajouter le total des ventes pour cette référence
  totals[sku] += sales[sku].sum

  sales[sku][day_of_week] = sale.to_i + sales[sku][day_of_week]
  sales[sku][8] = sales[sku].sum
end

more_sale = sales.sort_by { |_sku, sales| sales[8] }.reverse
sale1 = more_sale[0]
sale2 = more_sale[1]

i = 0
while i < sale1[1].size
  res1= res1.push(sale1[1][i])
  i += 1
end

p res1

# csv = CSV.open("result.csv", "w")
# csv << ["sku", "sun", "mon", "tue", "wed", "thu", "fri", "sat", "total"]
# csv << sale1
# csv << sale2
# csv.close
