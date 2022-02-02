function shuffle_in(m, tofind, debug = false)
  deck = collect(0:m-1)
  current_deck = deck
  first_shuffle = true
  i=0
  while current_deck != deck || first_shuffle == true
    index = findall(x->x==tofind, current_deck)[1] - 1
    #println(index)
    debug && println("$i Shuffles: $current_deck   Index($tofind) --> $index\n")
    left_deck = current_deck[1:Int(m/2)]
    right_deck = current_deck[Int(m/2+1):m]
    shuffled_deck = Vector{Int64}()
    for (x,y) in zip(left_deck, right_deck)
      push!(shuffled_deck, x)
      push!(shuffled_deck, y)
    end
    current_deck = shuffled_deck
    first_shuffle = false
  i += 1
  end
    index = findall(x->x==tofind, current_deck)[1] - 1
  debug && println("$i Shuffles:\t$current_deck\tIndex($tofind) --> $index\n")
  return i
end

function shuffle_out(m, tofind, debug = false)
  deck = collect(1:m)
  current_deck = deck
  first_shuffle = true
  i=0
  while current_deck != deck || first_shuffle == true
    index = findall(x->x==tofind, current_deck)[1] 
    debug && println("$i Shuffles:\t$current_deck\tIndex($tofind) --> $index\n")
    left_deck = current_deck[1:Int(m/2)]
    right_deck = current_deck[Int(m/2+1):m]
    shuffled_deck = Vector{Int64}()
    for (x,y) in zip(left_deck, right_deck)
      push!(shuffled_deck, y)
      push!(shuffled_deck, x)
    end
    current_deck = shuffled_deck
    first_shuffle = false
  i += 1
  end
    index = findall(x->x==tofind, current_deck)[1] - 1
  println("$i Shuffles: $current_deck   Index($tofind) --> $index\n")
  return i
end

function flip(m, tofind, debug=false)
  deck = Int.(ones(m))
  current_deck = deck
  first_shuffle = true
  i=0
  flip_tofind = Vector{Int64}()
  while current_deck != deck || first_shuffle == true
    index = findall(x->x==1, current_deck)
    #println(index)
    #debug && println("$i Shuffles: $current_deck    No. of 1s --> $(length(index))\n")
    
    pos_tofind = current_deck[(tofind*2^i % (m-1)) + 1]
    push!(flip_tofind, pos_tofind)

    debug && println("$i Shuffles:\t$current_deck\tFlip($tofind) --> $pos_tofind")
    left_deck = current_deck[1:Int(m/2)]
    right_deck = current_deck[Int(m/2+1):m]
    shuffled_deck = Vector{Int64}()
    for (x,y) in zip(left_deck, right_deck)
      push!(shuffled_deck, x)
      push!(shuffled_deck, -y)
    end
    current_deck = shuffled_deck
    first_shuffle = false
  i += 1
  end
  index = findall(x->x==1, current_deck)
  pos_tofind = current_deck[(tofind*2^i % (m-1)) + 1]
  push!(flip_tofind, pos_tofind)
  debug && println("$i Shuffles:\t$current_deck\tFlip($tofind) --> $pos_tofind")

  debug && println("\n\nFlips($tofind) = $flip_tofind")
  #debug && println("$i Shuffles: $current_deck    No. of 1s --> $(length(index))\n")
  #return i
  return i, flip_tofind
end

function print_vector(a)
  toprint = "["
  for i in 1:length(a)
    if i != length(a)
      toprint = a[i]<0 ? toprint*string(a[i])*", " : toprint*"+"*string(a[i])*", "
    else
      toprint = a[i]<0 ? toprint*string(a[i]) : toprint*"+"*string(a[i])
    end
  end
  toprint = toprint*"]"
end





print("\nNumber of cards in deck (m): ")
m = readline()
println("\nINSHUFFLE\n-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
println("Period = $(shuffle_in(parse(Int64, m), 31, true))\n")
#println("\nOUTSHUFFLE\n-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------")
#println("Period = $(shuffle_out(parse(Int64, m), 1, true))")
println()

#for m in 2:2:1000
#  println("$m : |$(shuffle_in(m))   $(shuffle_out(m))|")
#end
#

per = flip(parse(Int64, m), 5, true)[1]

println("Period of flips: $per")

println("\n\n\nRatio of shuffle period to flip period = $(per/shuffle_in(parse(Int64, m), 31))\n")


#for i in 2:2:1000
#  a = flip(i, 1, false)[2]
#  str = print_vector(a)
#  #b = flip(i, Int(i/2), false)[2]
#  println("$i Cards:\t$str")
#  #matches = filter(x->a[x]==b[x]==1, collect(1:(flip(i, 1, false)[1]+1))) .- 1
#  #println("$i Cards:    Matches = $matches")
#end


#for i =1:50
#  a = flip(52, i, false)[2]
#  if a == push!(append!([1], Int.(ones(15)).*(-1)), 1)
#    printstyled("Flip($i) = $a\n", color=:red)
#  else
#    println("Flip($i) = $a")
#  end
#end


#outliers = []
#for i = 2:2:10000
#  per = flip(i, false)[1]
#  
#  period = shuffle_in(i, 1)
#  ratio = per/period
#  
#  
#  if ratio == 2
#    printstyled("$i Cards:  Ratio of shuffle period to flip period = $ratio\n", color=:blue)
#  elseif ratio == 1
#    printstyled("$i Cards:  Ratio of shuffle period to flip period = $ratio\n", color=:green)
#    push!(outliers, i)
#  else
#    printstyled("$i Cards:  Ratio of shuffle period to flip period = $ratio\n", color=:red)
#  end
#
#end
#
#println("\n\n\nOutliers = $outliers")
