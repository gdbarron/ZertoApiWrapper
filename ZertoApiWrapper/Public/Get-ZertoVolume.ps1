<# .ExternalHelp ./en-us/ZertoApiWrapper-help.xml #>
function Get-ZertoVolume {
    [cmdletbinding( DefaultParameterSetName = "main" )]
    param(
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The type of volume. Please see Zerto API Documentation for possible values."
        )]
        [ValidateNotNullOrEmpty()]
        [string]$volumeType,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the VPG."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("vpgId")]
        [string]$vpgIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the datastore."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("datastoreId", "dsId")]
        [string]$datastoreIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the protected virtual machine."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("protectedVmId")]
        [string]$protectedVmIdentifier,
        [Parameter(
            ParameterSetName = "filter",
            HelpMessage = "The identifier of the owning virtual machine."
        )]
        [ValidateNotNullOrEmpty()]
        [Alias("owningVmId")]
        [string]$owningVmIdentifier
    )

    begin {
        $baseUri = "volumes"
        $returnObject = @()
    }

    process {
        # Process based on ParameterSetName
        switch ( $PSCmdlet.ParameterSetName ) {

            # If a filter is defined, build the query string and return selected information
            "filter" {
                $filter = Get-ZertoApiFilter -filterTable $PSBoundParameters
                $uri = "{0}{1}" -f $baseUri, $filter
                $returnObject = Invoke-ZertoRestRequest -uri $uri
            }

            # Default action is to return all Volumes.
            default {
                $returnObject = Invoke-ZertoRestRequest -uri $baseUri
            }
        }
    }

    end {
        return $returnObject
    }
}
