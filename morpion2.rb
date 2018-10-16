
class Player

  attr_accessor :name, :symb     #l'accesseur! il va le  lire et et le  modifier sans nécessiter de méthode

  def initialize(player_id, symb)
    puts " #{player_id}, Veuillez entrer votre nom ? "   #On demande aux joueur son non  pour la creation de son identifiant
    @name = gets.chomp
    @symb = symb          #x ou  o  depend des chois des users
  end
end

class Case  #ma case objet

  attr_accessor :status
  def initialize(val)

    @status = val

  end

end

#===============================

class Board

  def initialize   #ce qui permet de générer toute les cases dans une variable globale


    $c1 = Case.new(" ")
    $c2 = Case.new(" ")
    $c3 = Case.new(" ")
    $c4 = Case.new(" ")
    $c5 = Case.new(" ")
    $c6 = Case.new(" ")
    $c7 = Case.new(" ")
    $c8 = Case.new(" ")
    $c9 = Case.new(" ")

  end

  def display_board  #imprime la grille via une chaîne

     tab = " #{$c1.status} \| #{$c2.status} \| #{$c3.status} \n\-\-\-\|\-\-\-\|\-\-\- \n #{$c4.status} \| #{$c5.status} \| #{$c6.status} \n\-\-\-\|\-\-\-\|\-\-\- \n #{$c7.status} \| #{$c8.status} \| #{$c9.status} "

    puts tab

  end

  def display_tuto

    tab = " 1 \| 2 \| 3 \n\-\-\-\|\-\-\-\|\-\-\- \n 4 \| 5 \| 6 \n\-\-\-\|\-\-\-\|\-\-\- \n 7 \| 8 \| 9 "


    puts " tapez le numéro de la case que vous souhaitez jouer "
    puts tab
    puts "==============="

  end

end

#============================================================

class Game

  def initialize
    @turn = 0
    @choice_left = ["1","2","3","4","5","6","7","8","9"]
  end

  def game_start #Le moment où le jeu début


    puts "Loading ..."
    @players = []
    @players[0] = Player.new("Player1", "X")# crée le joueur 1
    @players[1] = Player.new("Player2", "O") # crée le joueur 2

    puts "Welcom"
    puts "Joueur 1 : #{@players[0].name} ------ Joueur 2 : #{@players[1].name}"

    @board = Board.new  # genere la grille
    @board.display_tuto # affichage


    while true #condition


      play_turn  # méthode dans laquelle le joueur fait son choix


      if win_combination_check == true    #méthode si le joueur a gagne
        puts "#{@players[@turn%2].name} winner"
        break #fin du programme

      elsif @turn == 8  # au dessus de 8 pas possible
        puts "Nop"

        break

      end

      @turn += 1
    end

  end

  def play_turn  #méthode pour les actions du joueur

    @current_player = @players[@turn%2].name
    puts "choisis une case"
    @player_choice = ""

    while true
      @player_choice = gets.chomp #le joueur donne un nomnbre entre 1 et 9

      unless @choice_left.include?(@player_choice) #si le nombre du joueur n'est pas disponible il retourne le message de la liste des cases disponibles
        puts "choisis un nombre entre 1 et 9 #{@choice_left}"

      else
        @choice_left.delete(@player_choice)
        break
      end
    end

      case @player_choice
      when "1"
        $c1.status = @players[@turn%2].symb
      when "2"
        $c2.status = @players[@turn%2].symb
      when "3"
        $c3.status = @players[@turn%2].symb
      when "4"
        $c4.status = @players[@turn%2].symb
      when "5"
        $c5.status = @players[@turn%2].symb
      when "6"
        $c6.status = @players[@turn%2].symb
      when "7"
        $c7.status = @players[@turn%2].symb
      when "8"
        $c8.status = @players[@turn%2].symb
      when "9"
        $c9.status = @players[@turn%2].symb
      end

      @board.display_board # affiche le tableau mis à jour puis revient à la boucle du jeu

    end

#==============================================================================

  def win_combination_check




    @tab = [[$c1.status,$c2.status,$c3.status],[$c4.status,$c5.status,$c6.status],[$c7.status,$c8.status,$c9.status]]

#check toutes les lignes et les autres colonnes



    (0..2).each do |i|
      if @tab[i][0] == @tab[i][1] && @tab[i][1] == @tab[i][2]
        return true unless @tab[i][0] == " "
    elsif @tab[0][i] ==@tab[1][i] && @tab[1][i] == @tab[2][i]
        return true unless @tab[0][i] == " "
    end
end

if ( @tab[0][0] == @tab[1][1] && @tab[1][1] == @tab[2][2] ) ||
  ( @tab[0][2] == @tab[1][1] && @tab[1][1] == @tab[2][0] )
      return true unless @tab[1][1] == " "
  else
      return false
    end


end

end

game = Game.new
game.game_start
