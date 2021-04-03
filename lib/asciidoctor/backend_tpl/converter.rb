# frozen_string_literal: true

#
# Asciidoctor core
#
# We have to put our custom Backend into this namespace
#
module Asciidoctor
  #
  # a backend extension needs its own namespace
  #
  module BackendTemplate
    #
    # The Custom Converter which will do the Asciidoctor AST conversion
    #
    class Converter
      include ::Asciidoctor::Converter
      register_for 'backend_tpl'

      #
      # initialize backend instance
      #
      # @param [String] backend name of the backend to initialize
      # @param [Hash] opts options for the backend
      #
      def initialize backend, opts
        super
        basebackend 'docbook5'
        filetype 'application/text'
        outfilesuffix '.tpl'
      end

      #
      # return a dummy string to show the convert method has been called
      # for the registered converter
      #
      # @param [Asciidoctor::AbstractNode] _node AST node to convert, usually the Document node
      # @param [String] _name current node name
      # @param [<Type>] _opts converter options
      #
      # @return [String] generated output string
      #
      def convert _node, _name = nil, _opts = {}
        "Well done: You plugged in a converter backend named 'backend_tpl'"
      end
    end
  end
end
