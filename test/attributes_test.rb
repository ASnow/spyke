require 'test_helper'

module Spike
  class AttributesTest < MiniTest::Test

    def test_predicate_methods
      stub_request(:get, 'http://sushi.com/recipes/1').to_return_json(data: { id: 1, title: 'Sushi' })

      recipe = Recipe.find(1)

      assert_equal true, recipe.title?
      assert_equal false, recipe.description?
    end

    def test_respond_to
      stub_request(:get, 'http://sushi.com/recipes/1').to_return_json(data: { id: 1, serves: 3 })

      recipe = Recipe.find(1)

      assert_equal true, recipe.respond_to?(:serves)
      assert_equal false, recipe.respond_to?(:story)
    end

    def test_setters
      recipe = Recipe.new
      recipe.title = 'Sushi'
      assert_equal 'Sushi', recipe.title
    end

    def test_equality
      assert_equal Recipe.new(id: 2, title: 'Fish'), Recipe.new(id: 2, title: 'Fish')
      refute_equal Recipe.new(id: 2, title: 'Fish'), Recipe.new(id: 2, title: 'Dinner')
      refute_equal Recipe.new(id: 2, title: 'Fish'), Recipe.new(id: 1, title: 'Fish')
    end

    def test_explicit_attributes
      recipe = Recipe.new
      assert_equal nil, recipe.title
      assert_raises NoMethodError do
        recipe.description
      end

      recipe = Recipe.new(title: 'Fish')
      assert_equal 'Fish', recipe.title
    end

  end
end