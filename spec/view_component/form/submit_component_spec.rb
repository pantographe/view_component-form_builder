# frozen_string_literal: true

RSpec.describe ViewComponent::Form::SubmitComponent, type: :component do
  let(:object)  { OpenStruct.new }
  let(:form)    { form_with(object) }
  let(:options) { {} }

  let(:component) { render_inline(described_class.new(form, "", options)) }
  let(:component_html_attributes) { component.css("input").first.attributes }

  context "with simple args" do
    it do
      expect(component.to_html).to eq(
        %(<input type="submit" name="commit" value="" data-disable-with="">)
      )
    end
  end

  include_examples "component with custom html classes"
  include_examples "component with custom data attributes"
end
