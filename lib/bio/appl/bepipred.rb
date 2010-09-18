#
# = bio/appl/bepipred.rb - Bepipred wrapper
#
# Copyright:: Copyright (C) 2010
# George Githinji <georgkam@gmail.com>
# License:: The Ruby License
#
# $Id:$
#
##############################################################################
# BepiPred predicts the location of linear B-cell epitopes in proteins using
# a combination of a hidden Markov model and a propensity scale method. The
# method is described in the following article:
#
# Improved method for predicting linear B-cell epitopes.
# Jens Erik Pontoppidan Larsen, Ole Lund and Morten Nielsen
# Immunome Research 2:2, 2006.
require 'bio/command'
require 'shellwords'

module Bio

  # == Description
  #
  # A wrapper for Bepipred linear B-cell epitope prediction program.
  #
  # === Examples
  #
  # require 'bio'
  # seq_file = 'test.fasta'
  #
  # factory = Bio::Bepipred.new(seq_file)
  # report = factory.query
  # report.class # => Bio::Bepipred::Report
  #
class Bepipred
  autoload :Report, 'bio/appl/bepipred/report'
  
  # Creates a new Bepipred execution wrapper object
  def initialize(program='bepipred',file_name)
    @program = program
    @file_name = file_name
  end
  
  # name of the program ('bepipred' in UNIX/Linux)
  attr_accessor :program

  # options
  attr_accessor :score_threshold
  
  # return the names of the input sequences
  attr_reader :sequence_names

  # expose the internal datastructure so that it can be manipulated directly.
  attr_accessor :result_list
  
  def sequence_names(file)
    sequence_names = []
    Bio::FlatFile.auto(@file) do |f|
      f.each do |entry|
        sequence_names << entry.definition
      end
    end
    sequence_names
  end

  #TODO create a commandline as an array cmd
  def make_command
    cmd = [@program,@file_name ]  
    Bio::Command.query_command(cmd)
  end
  
end
end

#How to use the script 
#b = Bio::Bepipred.new
#puts b.make_command()
