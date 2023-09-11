Describe "Testing arithmetic_expressions.exe" {
    It "Should return correct k for m=100" {
        $output = & .\arithmetic_expressions.exe 100
        $output | Should -BeExactly "The largest k where 2*k < m is 49"
    }

    It "Should return correct k for m=50" {
        $output = & .\arithmetic_expressions.exe 50
        $output | Should -BeExactly "The largest k where 2*k < m is 24"
    }

    It "Should return correct k for m=10" {
        $output = & .\arithmetic_expressions.exe 10
        $output | Should -BeExactly "The largest k where 2*k < m is 4"
    }
}
