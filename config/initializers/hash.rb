class Hash
    def pluck keys
        keys.inject({}) do |result, element|
            result[element] = self[element]
            result
        end
    end
end