bio_bank = {
  fridge: {n:3, type: "Congélateur"},
  shelf: {n: 4, type: "Etagère"},
  rack: {n: 6, type: "Rack"},
  box: {n: 20, type: "Boite 9x9"}
}

a = ["parent.code,code,type"]

i_f = i_s = i_r = i_b = 1

for i in 1..bio_bank[:fridge][:n] do
  f_code = "frige-#{i_f}"
  a.push ",#{f_code},#{bio_bank[:fridge][:type]}"
  for j in 1..bio_bank[:shelf][:n] do
    s_code = "shelf-#{i_s}"
    a.push "#{f_code},#{s_code},#{bio_bank[:shelf][:type]}"
    if i_f < bio_bank[:fridge][:n] # NO RACK NOR BOXES IN THE BACKUP FRIDGE
      for k in 1..bio_bank[:rack][:n] do
        r_code = "rack-#{i_r}"
        a.push "#{s_code},#{r_code},#{bio_bank[:rack][:type]}"
        for l in 1..bio_bank[:box][:n] do
          b_code = "box-#{i_b}"
          a.push "#{r_code},#{b_code},#{bio_bank[:box][:type]}"
          i_b += 1
        end
        i_r += 1
      end
      i_s += 1
    end
  end
  i_f += 1
end

File.open('biobank.csv', 'w+') do |f|
  a.each { |e| f << "#{e}\n" }
end