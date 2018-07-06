#¿Cómo representamos una carta? Una figura y un valor
# ¿Cómo representamos una baraja? 52 cartas
# ¿Cómo representamos las cartas que tiene el jugador y el repartidor'

#------------------ESTRUCTURA DE DATOS--------------------------------#
class Card
	attr_reader :suit, :value

	def initialize(suit,value)
		@suit = suit
		@value = value
	end

	def value
		return 10 if ["J", "Q", "K"].include?(@value)
		return 11 if @value == "A"		
		return @value
	end

	#solucionar problema de imprimir cartas
	def to_s
		"#{@value}-#{@suit}"
	end
end
#creación de cartas una por una
# c1 = Card.new(:hearts, 9)
# c2 = Card.nwe(:clubs,5)

class Deck
	attr_reader :cards

	def initialize
		@cards = []
		build_cards
	end

	#sacar una carta de forma aleatoria de la baraja
	def take!
		@cards.shift
	end

#creación de todas las 52 cartas de la baraja con ciclo
	private 
	def build_cards
		[:clubs, :diamonds, :spades, :hearts].each do |suit|
		(2..10).each do |number|
			@cards << Card.new(suit,number)
			end
			["J", "Q", "K","A"].each do |face|
				@cards << Card.new(suit,face)
			end
		end
		#mezclar cartas
		@cards.shuffle!	
	end
end

#mano del jugador
class Hand
	attr_reader :cards

	#inicializar cartas vacías
	def initialize(deck)
		@deck = deck
		@cards = []
	end

	#cambia la esctructura o estado del Deck
	def hit!
		@cards << @deck.take!
	end

	def value
		val = 0
		@cards.each do |card|
			val += card.value
		end
		return val
	end

	#solucionar problema de imprimir cartas
	def to_s
		str = ""
		@cards.each do |card|
			str += "#{card}     "
		end	
		str.strip	
	end
end

#------------------------LÓGICA------------------------------------------------#
=begin
1.repartir las cartas
2.preguntar al usuario si desea carta o se planta
	si pide carta
		si se pasa, ir al punto 4
		De lo contrario, volver al punto 2
	si se planta
		ir al punto 3
3. Determinar el valor que tiene el repartidor
	si es < 17, entregarse otra carta
		si se pasa, ir al punto 4
		de lo contrario, volver al punto 3
	de lo contrario
		ir al punto 4
4.determina el ganador
	si el usuario se pasó, gana el repartidor
	si el repartidor se pasó, gana el usuario
	si tienen el mismo valor, quedaron empatados
	si el repartidor tiene más que el usuario, gana el repartidor
	de lo contrario, gana el usuario
5.volver al punto 1 (nuevo juego)
=end

#repartir cartas
deck = Deck.new
dealer = Hand.new(deck)
player = Hand.new(deck)

player.hit!
player.hit!
dealer.hit!

puts "Repartidor: #{dealer}"
puts "jugador:    #{player}"

puts
#preguntar al usuario
puts "Tu turno:"

while player.value <21 # si tiene cartas menor a 21
	print " ¿Carta(C) o plantas(P)? "
	option = gets.chomp
	if option == "C"
		player.hit!
		puts "  #{player}"
		puts
	elsif option == "P"
		break #rompe el ciclo y sigue con la siguiente línea	
	end
end

#repartidor

if player.value <= 21
	puts
	puts "Turno del repartidor:"

	dealer.hit!
	puts "  #{dealer}"
	while dealer.value <17
		dealer.hit!
	puts "  #{dealer}"
	end
end

#determinar quien ganó
puts
if player.value > 21
	puts "Perdiste :("
elsif dealer.value > 21
	puts "Ganaste!"
elsif dealer.value == player.value
	puts "Empatados"
else
	puts "Ganaste!"
end
# puts "!!!!! Repartidor: #{dealer}"
# puts "!!!!! Jugador: #{player}"
	







#------------------------PRUEBAS-----------------------------------------------#
#se crea una baraja de 52 cartas
# deck = Deck.new
#se crea la mano del jugador
# hand = Hand.new(deck)
#se muestra cuantas cartas tiene la baraja
# puts "la baraja tiene #{deck.cards.length} cartas"
#verificar cuantas cartas tiene la mano del jugador
# puts "la mano tiene #{hand.cards.length} cartas"
#se muestra que se quita una carta
# hand.hit!
# puts "La baraja tiene #{deck.cards.length} cartas"
#verificar cuantas cartas tiene la mano del jugador
# puts "la mano tiene #{hand.cards.length} cartas"

