class SVGMapper
	ORIGINAL_MAP = 'us_map.svg'
	XPATH_FOR_COUNTY = "//svg:path[@inkscape:label='Cuyahoga, OH']"
	XPATH_NAMESPACES = {'svg': "http://www.w3.org/2000/svg", 'inkscape': "http://www.inkscape.org/namespaces/inkscape"}
	
	def initialize(output_file_name, opts = {})
		@output_file_name = output_file_name
		parser = opts[:parser] || Nokogiri::XML
		@doc = parser.parse(File.read(ORIGINAL_MAP)).dup
	end

	def color_county!(county, color)
		node = @doc.at_xpath(XPATH_FOR_COUNTY, XPATH_NAMESPACES)
		style = node.styles
		style['fill'] = color
		node.styles = style
	end

	def close
		File.write(@output_file_name, @doc.to_xml)
	end
end
