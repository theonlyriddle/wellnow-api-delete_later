module ApplicationHelper
    def name_of_the_day(day)
        if day == 1
            "Monday"
        elsif day == 2
            "Tuesday"
        elsif day == 3
            "Wednesday"
        elsif day == 4
            "Thursday"
        elsif day == 5
            "Friday"
        elsif day == 6
            "Saturday"
        else
            "Sunday"
        end
    end
end
